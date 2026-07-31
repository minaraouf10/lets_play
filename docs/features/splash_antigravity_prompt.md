# Antigravity prompt — Splash Screen

Copy everything inside the block below and paste it as a single message.

---

```
Implement a splash screen in this existing Flutter project: a native (pre-Flutter-engine) static
splash, followed by an in-app animated LEGO build-up that rests on a logo card until tapped.

READ FIRST, BEFORE WRITING ANY CODE:
1. docs/features/splash_feature_spec.md  — the full spec for this task. Follow it exactly.
2. docs/features/auth_feature_spec.md §2 "Existing conventions" — the project's coding rules.

This repo already has a working Clean Architecture setup (Cubit + injectable + go_router +
dartz). Match the existing patterns exactly. Do NOT introduce freezed, Provider, Riverpod,
setState-based state, or a new folder structure.

GOAL
  app cold start
    -> [native splash: frame 1, static, shown by the OS before Flutter boots]
    -> /splash route: frame 1 (again, briefly, for a seamless handoff) -> 2 -> 3 -> 4 -> logo card
    -> logo card STAYS on screen, waits for a tap (does NOT auto-navigate)
    -> tap -> /login -> /onboarding -> /game/letter

This is two layers because they solve different problems. flutter_native_splash can only show ONE
static raster image before the Flutter engine has started — it cannot animate multiple frames.
Everything after that (the real 4-frame build-up) is a normal Flutter route.

WHAT TO BUILD
Create lib/modules/splash/presentation/ with:
  cubit/splash_cubit.dart + cubit/splash_state.dart   (state is `part of` the cubit file)
  pages/splash_page.dart
  widgets/splash_brick_frame.dart
  widgets/splash_logo_card.dart

The splash is presentation-only. It fetches nothing and has no business rules, so do NOT create
domain/ or data/ folders, entities, repositories, or use cases for it.

ASSETS — already in the repo at assets/images/splash/, do not redraw or replace them:
  lego_splash_1.svg     375x229   transparent, bricks only
  lego_splash_2.svg     375x344   transparent, bricks only
  lego_splash_3.svg     375x561   transparent, bricks only
  lego_splash_4.svg     375x812   opaque, paints its own yellow background
  lego_splash_logo.svg  103x141   transparent, yellow wordmark

Durations: frame1 300ms, frame2 300ms, frame3 300ms, frame4 500ms. Define them as named Duration
constants in the cubit, not as inline literals. There is NO duration for the logo stage — it does
not time out.

FOUR THINGS THAT WILL BREAK THIS IF YOU MISS THEM:
1. These are SVG files and flutter_svg is NOT yet a dependency. Add `flutter_svg: ^2.0.10` to
   pubspec.yaml and register the folder under `flutter: assets:` as `assets/images/splash/`
   (only assets/images/icons/ is registered right now). Image.asset silently fails on .svg.
2. Frames 1-3 are transparent. The page must paint the yellow canvas (#FEDD05) itself or those
   frames render on white. Frame 4 is opaque and covers it. The logo card is the ONE place that
   must paint a DIFFERENT (red) background itself — the page-level Scaffold background stays
   yellow throughout, so if the logo card doesn't paint its own ColoredBox(color: splashRed), it
   will incorrectly show on yellow instead of red.
3. The bricks build DOWNWARD from the top. The four frames are the same artwork growing taller on
   a fixed 375-wide canvas. Render each with Alignment.topCenter + BoxFit.fitWidth +
   width: MediaQuery.sizeOf(context).width, wrapped in ClipRect. Do NOT center them vertically and
   do NOT stretch to fill — either one makes the stack jump between frames.
4. flutter_native_splash cannot render an SVG or animate — it needs exactly one raster PNG, and it
   must have real transparency (not opaque white) so the yellow color config shows through the
   gaps. There is no SVG-to-PNG CLI available in this environment (no rsvg-convert/inkscape). To
   rasterize lego_splash_1.svg to a PNG, write a ONE-TIME throwaway flutter_test widget test that:
     - pumps SvgPicture.asset('assets/images/splash/lego_splash_1.svg') inside a bare
       Directionality (NO Material/Scaffold/MaterialApp ancestor — those paint an opaque
       background and silently bake solid white into the PNG instead of transparency)
     - sets tester.view.physicalSize explicitly before pumping (the default 800x600 test window
       clamps a 1125x687 target silently otherwise)
     - captures via RenderRepaintBoundary.toImage() -> toByteData(format: ui.ImageByteFormat.png)
     - writes the bytes to assets/images/splash/native_splash_frame1.png
     - VERIFIES it actually has alpha (sample raw RGBA pixels, confirm alpha < 10 in gap areas) —
       do not just eyeball a preview; some file preview tools composite transparent PNGs onto
       white for DISPLAY only, which can look identical to a real opaque-white bug
   Delete the throwaway test file once the PNG exists. Render at 3x scale (1125x687) for crispness.

Cross-fade (~250ms, milliseconds not microseconds) ONLY on the frame-4 -> logo-card transition.
Frames switch instantly otherwise; they are stop-motion and fading between them looks like a
glitch.

TOKENS — add these, and do not hardcode any color or size in a widget:
  app_colors.dart:      splashYellow = Color(0xFFFEDD05)
                        splashRed    = Color(0xFFFF2D55)
                        splashLogo   = Color(0xFFFFDD00)
  app_dimensions.dart:  splashLogoWidth = 103, splashCanvasWidth = 375
  app_assets.dart:      a List<String> splashFrames of the four frame paths, plus splashLogo

CUBIT
@injectable, extends Cubit<SplashState>, constructor takes no arguments, initial state is
frameIndex: 0 / stage: SplashStage.bricks (frame 1 — same as what the native splash already
showed, so there is no visual jump at the native-to-Flutter handoff).
State: single Equatable class with `enum SplashStage { bricks, logo, finished }` + `int frameIndex`
+ copyWith + props — same style as the existing AuthState / OnboardingState.
`Future<void> play()` holds frame 1, then steps frameIndex 1->3 (frames 2,3,4) with sequential
`await Future.delayed(...)`, then emits stage: SplashStage.logo and RETURNS. It must NOT emit
`finished` itself and must NOT use Timer.periodic.
A separate `void continueFromLogo()` method is the ONLY way to reach stage: SplashStage.finished —
guard it with `if (state.stage != SplashStage.logo) return;`. This is called from the logo card's
tap handler, not from a timer.
Guard EVERY emit with `if (isClosed) return;` — play() outlives the widget if the user backgrounds
the app mid-splash, and emitting after close throws StateError.

PAGE
SplashPage is a StatelessWidget that returns
  BlocProvider(create: (_) => getIt<SplashCubit>()..play(), child: const _SplashView())
Start the animation with ..play() in BlocProvider.create. Do NOT read the cubit from a
StatefulWidget initState — that throws ProviderNotFoundException because the provider is not yet
above that context.
_SplashView uses BlocConsumer with listenWhen: (p, c) => p.stage != c.stage, and on
SplashStage.finished calls context.goNamed(AppRoutes.loginName). In the builder, when
stage is logo OR finished, render
  SplashLogoCard(onTap: () => context.read<SplashCubit>().continueFromLogo())
otherwise render SplashBrickFrame(assetPath: AppAssets.splashFrames[state.frameIndex]).

SplashLogoCard must accept a `VoidCallback? onTap`, wrap its content in
`GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, ...)` so the WHOLE screen is
tappable (not just the small wordmark graphic), and paint `ColoredBox(color: AppColors.splashRed)`
as its own background per point 2 above.

ROUTING
Add to core/routing/app_routes.dart:
  static const String splash = '/splash';
  static const String splashName = 'splash';
In core/routing/app_router.dart: change initialLocation to AppRoutes.splash and register the splash
GoRoute first. The router deliberately has NO redirect and NO refreshListenable right now — keep it
that way, do not add auth guards. Use goNamed (not push) so Back from Login does not return to the
splash. Never write a raw route path string in a widget.

NATIVE SPLASH SETUP
Add to pubspec.yaml dev_dependencies: flutter_native_splash: ^2.4.1
Add this as a TOP-LEVEL pubspec.yaml key (a sibling of `dependencies:`, NOT nested under
`flutter:`):
  flutter_native_splash:
    color: "#FEDD05"
    image: assets/images/splash/native_splash_frame1.png
    android_12:
      color: "#FEDD05"
      image: assets/images/splash/native_splash_frame1.png
    web: false
After the PNG exists (see point 4 above), run:
  dart run flutter_native_splash:create
This generates/overwrites Android drawable + styles.xml and iOS launch images automatically —
do not hand-edit those generated files; re-run the command instead if the PNG or config changes.

AFTER IMPLEMENTING, run and make all pass:
  flutter pub get
  dart run flutter_native_splash:create
  dart run build_runner build --delete-conflicting-outputs
  flutter analyze     -> must report zero errors AND zero warnings

Then confirm: SplashCubit appears as gh.factory<SplashCubit> in
lib/core/dependency_injection/injection.config.dart, and that waiting 5+ seconds on the logo card
does NOT navigate anywhere (only a tap should).

DO NOT: add a skip button, add sound, preload data during the splash, modify the
authentication / onboarding / games / learning modules, or leave the throwaway PNG-generation test
file behind once native_splash_frame1.png has been produced.
```
