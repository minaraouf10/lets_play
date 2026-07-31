# Feature Spec — Splash Screen ("Let's Play!" Arabic learning app)

> **Audience:** an AI coding agent implementing this feature in the existing Flutter project.
> **Companion doc:** `docs/features/auth_feature_spec.md` — read its §2 "Existing conventions"
> first. Every rule there (Cubit-only, `AppColors`/`AppDimensions`/`AppTextStyles`, no hardcoded
> numbers, `injectable` DI, `AppRoutes` constants, relative imports) applies here unchanged.

---

## 1. Goal

Replace the app's cold-start with an animated LEGO build-up splash, then hand off to Login:

```
app start ─▶ [native splash: frame 1, static] ─▶ /splash [frame1→2→3→4→logo, animated] ─▶ (tap) ─▶ /login ─▶ /onboarding ─▶ /game/letter
```

Two layers, because they solve two different problems:

- **Native splash** (`flutter_native_splash`) — a single static raster image the OS shows
  instantly while the Android/iOS process boots and the Flutter engine initializes, before any
  Dart code has run. It cannot animate; it exists only to avoid a blank/white flash at cold start.
  Shows frame 1.
- **In-app splash** (`SplashPage`, a normal route) — takes over the instant Flutter can paint. Its
  cubit's *initial state* is also frame 1 (so there is no visual jump at the native→Flutter
  handoff), holds it for one frame duration, then animates 2 → 3 → 4 → logo card. **The logo card
  is the resting frame — it stays on screen and waits for a tap**, it does not auto-navigate.

**IMPORTANT — do not implement this as "5 frames in order" run purely by a timer.** The logo card
no longer times out on its own — advancing past it requires an explicit user tap. See §5 and §7.2.

---

## 2. Assets (already in the repo — do NOT redraw or replace)

`assets/images/splash/`

| # | File | Intrinsic size | Has own background? |
|---|---|---|---|
| 1 | `lego_splash_1.svg` | 375 × 229 | ❌ transparent — bricks only |
| 2 | `lego_splash_2.svg` | 375 × 344 | ❌ transparent — bricks only |
| 3 | `lego_splash_3.svg` | 375 × 561 | ❌ transparent — bricks only |
| 4 | `lego_splash_4.svg` | 375 × 812 | ✅ opaque, paints its own yellow `#FEDD05` |
| 5 | `lego_splash_logo.svg` | 103 × 141 | ❌ transparent — yellow wordmark only |

### ⚠️ Facts that WILL break the implementation if ignored

1. **These are SVGs, and `flutter_svg` is NOT a dependency yet.** Add it (§3). Do not try to render
   them with `Image.asset` — that silently fails for `.svg`.
2. **Frames 1–3 have no background.** The page must paint the yellow canvas itself, otherwise the
   first three frames render on the default white scaffold. Frame 4 is opaque and covers it.
3. **The bricks build downward from the top.** The frames are the *same artwork* growing taller
   (229 → 344 → 561 → 812 on a fixed 375-wide canvas). They must be **top-aligned and width-fitted**,
   never centered or stretched — centering makes the stack visibly jump between frames.
4. **`flutter_native_splash` cannot render an SVG or animate.** It bakes exactly one *raster* image
   into native launch resources (Android drawable / iOS launch storyboard) at build time, shown
   before the Flutter engine boots. `lego_splash_1.svg` must be pre-rasterized to a PNG (see §3.1) —
   pointing the package config at a `.svg` path does not work.

### Design canvas
375 × 812 logical px (iPhone X). Scale **by width**; let height follow the aspect ratio and overflow
off the bottom of shorter screens. Never distort.

---

## 3. `pubspec.yaml` changes

```yaml
dependencies:
  flutter_svg: ^2.0.10   # add — required to render the splash SVGs

dev_dependencies:
  flutter_native_splash: ^2.4.1   # add — generates the native pre-engine splash

flutter:
  assets:
    - assets/images/icons/
    - assets/images/splash/   # add — folder is not registered yet

# Top-level key, NOT nested under `flutter:`.
flutter_native_splash:
  color: "#FEDD05"
  image: assets/images/splash/native_splash_frame1.png
  android_12:
    color: "#FEDD05"
    image: assets/images/splash/native_splash_frame1.png
  web: false
```

Then `flutter pub get`.

### 3.1 Rasterize frame 1 to PNG (one-time)

`flutter_native_splash` needs a raster image, not `lego_splash_1.svg` directly, and it must be
**transparent** (not baked onto a white background) so the `color: "#FEDD05"` shows through the
gaps — the same gaps `SplashBrickFrame` leaves transparent in-app. There is no SVG→PNG CLI tool in
this environment (no `rsvg-convert`/`inkscape`/`cairosvg`), so rasterize inside Flutter itself:

1. Write a throwaway `flutter_test` widget test that pumps `SvgPicture.asset('assets/images/splash/lego_splash_1.svg')`
   inside a plain `Directionality` (**no** `Material`/`Scaffold`/`MaterialApp` ancestor — those
   paint an opaque background and will bake solid white into the PNG, silently breaking
   transparency).
2. Set `tester.view.physicalSize` explicitly before pumping (the default 800×600 test window will
   silently clamp a 1125×687 target otherwise).
3. Capture via `RenderRepaintBoundary.toImage()` → `toByteData(format: ui.ImageByteFormat.png)` →
   write to `assets/images/splash/native_splash_frame1.png`.
4. Delete the throwaway test file once the PNG exists — it is a one-time generation step, not a
   real test.
5. **Verify it actually has transparency**, don't just eyeball it: sample raw RGBA pixels at a few
   coordinates and confirm `alpha < 10` in the gap areas. Note that many image previewers
   (including some editor "read file" tools) composite transparent PNGs onto a white canvas for
   *display purposes only* — a preview that looks solid white does not mean the file lacks alpha;
   check the actual bytes.

Run at 3× scale (1125×687) for a crisp result on high-density screens.

### 3.2 Generate the native splash

```bash
dart run flutter_native_splash:create
```

This writes/overwrites, and must be re-run after any change to the PNG or to the
`flutter_native_splash:` config block:
- `android/app/src/main/res/drawable{,-v21}/launch_background.xml`
- `android/app/src/main/res/values{,-v31,-night,-night-v31}/styles.xml`
- iOS `Images.xcassets` splash images + `Info.plist` status-bar entry

These generated files are build artifacts of the config, not hand-edited.

---

## 4. Tokens to add first

**`core/theme/app_colors.dart`** — values sampled from the SVG sources, exact:

```dart
// Splash.
static const Color splashYellow = Color(0xFFFEDD05); // canvas behind frames 1-3
static const Color splashRed    = Color(0xFFFF2D55); // logo-card background
static const Color splashLogo   = Color(0xFFFFDD00); // wordmark (baked into the SVG)
```

**`core/constants/app_dimensions.dart`**:

```dart
// Splash.
static const double splashLogoWidth = 103; // logo SVG intrinsic width
static const double splashCanvasWidth = 375; // design canvas width
```

**`core/constants/app_assets.dart`**:

```dart
static const String _splash = 'assets/images/splash';

static const List<String> splashFrames = [
  '$_splash/lego_splash_1.svg',
  '$_splash/lego_splash_2.svg',
  '$_splash/lego_splash_3.svg',
  '$_splash/lego_splash_4.svg',
];
static const String splashLogo = '$_splash/lego_splash_logo.svg';
```

---

## 5. Timing

| Phase | Duration | Screen |
|---|---|---|
| Native splash (frame 1) | until Flutter engine is ready (device-dependent, not code-controlled) | yellow + bricks (229h) |
| Frame 1 (in-app, initial state) | 300 ms | yellow + bricks (229h) — same as native, for a seamless handoff |
| Frame 2 | 300 ms | yellow + bricks (344h) |
| Frame 3 | 300 ms | yellow + bricks (561h) |
| Frame 4 | 500 ms | full-screen bricks (812h) |
| Logo card | **indefinite — waits for a tap** | red + centered wordmark |

Put the durations in the cubit as named constants, not inline literals:

```dart
static const Duration frame1 = Duration(milliseconds: 300);
static const Duration frame2 = Duration(milliseconds: 300);
static const Duration frame3 = Duration(milliseconds: 300);
static const Duration frame4 = Duration(milliseconds: 500);
```

There is **no** duration constant for the logo stage — `play()` emits `SplashStage.logo` and
returns; nothing times out. The cubit exposes a separate `continueFromLogo()` method (§7.2), called
from a tap handler, which is the only thing that can move the state to `SplashStage.finished`.

Add a 250 ms `FadeTransition`/`AnimatedSwitcher` cross-fade **only** on the frame 4 → logo card
transition (the yellow→red cut) — **milliseconds, not microseconds**; `Duration(microseconds: 250)`
is ~0.00025 s and reads as an instant cut, not a fade. Frames switch instantly otherwise — they are
stop-motion, and fading between them looks like a glitch rather than snapping bricks.

---

## 6. Files to create

A splash has **no data to fetch and no business rules**, so it is **presentation-only**. Do *not*
invent empty `domain/` and `data/` folders, entities, repositories, or use cases for it — that is
ceremony, not clean architecture. The cubit owns a pure timing state machine.

```
lib/modules/splash/
  presentation/
    cubit/
      splash_cubit.dart
      splash_state.dart          # part of splash_cubit.dart
    pages/
      splash_page.dart
    widgets/
      splash_brick_frame.dart    # yellow canvas + top-aligned, width-fitted SVG frame
      splash_logo_card.dart      # red canvas + centered wordmark
```

---

## 7. Contracts

### 7.1 State

```dart
part of 'splash_cubit.dart';

enum SplashStage { bricks, logo, finished }

class SplashState extends Equatable {
  const SplashState({
    this.stage = SplashStage.bricks,
    this.frameIndex = 0,
  });

  final SplashStage stage;
  /// Index into AppAssets.splashFrames. Only meaningful when stage == bricks.
  final int frameIndex;

  SplashState copyWith({SplashStage? stage, int? frameIndex}) => SplashState(
        stage: stage ?? this.stage,
        frameIndex: frameIndex ?? this.frameIndex,
      );

  @override
  List<Object?> get props => [stage, frameIndex];
}
```

Follow the project's single-class + `status`-enum state style (see `AuthState`, `OnboardingState`).

### 7.2 Cubit

```dart
@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit()
      : super(const SplashState(stage: SplashStage.bricks, frameIndex: 0));

  /// Holds frame 1 briefly (matches the native splash, for a seamless
  /// handoff), then steps through frames 2→3→4, then rests on the logo
  /// stage. Does NOT navigate and does NOT time out the logo stage.
  Future<void> play();

  /// Called from the logo card's tap handler. The only way to leave
  /// SplashStage.logo. No-ops if called from any other stage.
  void continueFromLogo();
}
```

- Initial state is `frameIndex: 0` (frame 1) — same frame the native splash already showed, so
  there's no visual jump at the native→Flutter handoff. `play()` holds it for `frame1` duration,
  then emits `frameIndex` 1→3 in order (frames 2, 3, 4), each held for its own duration. It then
  emits `stage: SplashStage.logo` and **returns** — it does not emit `finished` itself.
- `continueFromLogo()` is the only path to `stage: SplashStage.finished`, and only from
  `SplashStage.logo`:
  ```dart
  void continueFromLogo() {
    if (state.stage != SplashStage.logo) return;
    emit(state.copyWith(stage: SplashStage.finished));
  }
  ```
- **Guard every `emit` with `if (isClosed) return;`** — `play()` outlives the widget if the user
  backgrounds the app mid-splash, and emitting after close throws a `StateError`.
- No `Timer.periodic`. Sequential `await Future.delayed(...)` is clearer and cancels naturally.

### 7.3 Page

```dart
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>()..play(),
      child: const _SplashView(),
    );
  }
}
```

`_SplashView` uses `BlocConsumer<SplashCubit, SplashState>`:
- `listenWhen: (p, c) => p.stage != c.stage`
- `listener:` on `SplashStage.finished` → `context.goNamed(AppRoutes.loginName)`
- `builder:` → when `stage == logo` **or** `finished`, render
  `SplashLogoCard(onTap: () => context.read<SplashCubit>().continueFromLogo())`; otherwise
  `SplashBrickFrame(assetPath: AppAssets.splashFrames[state.frameIndex])`

The `finished` branch still renders `SplashLogoCard` (rather than nothing) purely to avoid a blank
frame during the one build where `listener` fires `goNamed` and the route transition hasn't
painted yet — it is never visible to the user for more than a frame.

> Create the cubit with `..play()` in `BlocProvider.create` — **not** in a `StatefulWidget`'s
> `initState` reading the provider, which throws `ProviderNotFoundException` because the provider
> is not yet above that context.

### 7.4 Widgets

**`SplashBrickFrame`** — the part most likely to be got wrong:

```dart
Container(
  color: AppColors.splashYellow,        // frames 1-3 are transparent
  width: double.infinity,
  height: double.infinity,
  child: Align(
    alignment: Alignment.topCenter,     // bricks build downward from the top
    child: SvgPicture.asset(
      assetPath,
      width: MediaQuery.sizeOf(context).width,
      fit: BoxFit.fitWidth,             // scale by width, preserve aspect ratio
      alignment: Alignment.topCenter,
    ),
  ),
)
```

Wrap in `ClipRect` so frame 4 cannot overflow-paint on short screens.

**`SplashLogoCard`** — must accept a `VoidCallback? onTap` and make the *entire card* tappable
(`GestureDetector(behavior: HitTestBehavior.opaque, ...)`), not just the small wordmark graphic —
this is the resting frame the user has to actively tap through. It must **paint its own red
background** (`ColoredBox(color: AppColors.splashRed)`) — the enclosing `Scaffold.backgroundColor`
is fixed to `AppColors.splashYellow` for the whole page (it's what shows through the transparent
gaps in `SplashBrickFrame`), so the logo card is the one place that has to override it itself:

```dart
class SplashLogoCard extends StatelessWidget {
  const SplashLogoCard({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ColoredBox(
        color: AppColors.splashRed,
        child: SizedBox.expand(
          child: Center(
            child: SvgPicture.asset(
              AppAssets.splashLogo,
              width: AppDimensions.splashLogoWidth,
            ),
          ),
        ),
      ),
    );
  }
}
```

Both are full-bleed: no `SafeArea`, no `AppBar`, and `Scaffold(backgroundColor: AppColors.splashYellow)`
so the status-bar area matches during frames 1–3.

---

## 8. Routing

**`core/routing/app_routes.dart`** — add:
```dart
static const String splash = '/splash';
static const String splashName = 'splash';
```

**`core/routing/app_router.dart`**:
- Change `initialLocation:` from `AppRoutes.login` to `AppRoutes.splash`.
- Register the route **first** in the `routes:` list:

```dart
GoRoute(
  path: AppRoutes.splash,
  name: AppRoutes.splashName,
  builder: (context, state) => const SplashPage(),
),
```

- The router currently has **no `redirect` and no `refreshListenable`** (prototype linear flow).
  Keep it that way — do not add guards.
- Use `context.goNamed(...)` (not `push`) so the splash is replaced and the hardware Back button
  from Login does not return to it.

Resulting chain: `/splash → /login → /onboarding → /game/letter?lessonId=l1_alef`.

---

## 9. DI

`SplashCubit` is `@injectable` (factory scope, like every other cubit). After adding the annotation:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Verify `gh.factory<SplashCubit>(...)` appears in `lib/core/dependency_injection/injection.config.dart`.

---

## 10. Acceptance criteria

1. `flutter pub get` succeeds with `flutter_svg` and `flutter_native_splash` added.
2. `flutter analyze` → **0 errors, 0 warnings**.
3. `build_runner` regenerates `injection.config.dart` with `SplashCubit` registered.
4. `dart run flutter_native_splash:create` succeeds and updates the Android/iOS launch resources
   listed in §3.2.
5. App cold-starts showing frame 1 on yellow **before Flutter has painted anything** (no white
   flash) — this is the native layer.
6. `SplashPage` takes over showing the same frame 1, then animates 2→3→4, each anchored to the top
   of the screen, with the stack visibly growing downward and **no horizontal jump or vertical
   re-centering** between frames.
7. Frames 1–4 show the yellow `#FEDD05` canvas below the bricks (nothing white) — including the
   native frame 1 (verify the PNG has real alpha per §3.1 step 5, not opaque white baked in).
8. The logo card shows the yellow wordmark centered on a **red** background, and **stays there
   indefinitely** — waiting 5+ seconds on it must NOT navigate anywhere.
9. Tapping anywhere on the logo card navigates to Login immediately.
10. Pressing Back on Login does **not** return to the splash.
11. Backgrounding the app mid-splash and returning does not crash (`emit` after close is guarded).
12. Runs correctly on a short screen (e.g. 360×640) — bricks clip at the bottom, never squash.

---

## 11. Explicitly out of scope

Do **not**: add a skip button, add sound, change the `authentication` / `onboarding` / `games` /
`learning` modules, or leave test/generator scaffolding behind — delete the throwaway rasterization
test (§3.1) once `native_splash_frame1.png` exists; only the generated PNG and the native
Android/iOS launch resources from `flutter_native_splash:create` should remain as build output.
