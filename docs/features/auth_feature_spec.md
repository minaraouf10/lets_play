# Feature Spec — Authentication & Onboarding ("Let's Play!" Arabic learning app)

> **Audience:** an AI coding agent implementing this feature in the existing Flutter project.
> **Rule #1:** This project already has a working Clean Architecture skeleton. **Follow the existing
> conventions exactly.** Do not introduce new state-management, DI, routing, or error-handling
> patterns. Read the "Existing conventions" section before writing a single line.

---

## 1. Goal

Implement the **Auth feature** end-to-end from the design:

1. **Login screen** (full design fidelity — currently only a bare-bones version exists).
2. **Onboarding questionnaire** ("Tell us about yourself") — 5 steps shown after login.
3. Wire routing so that **pressing "Sign in" logs the user straight in** (mock auth, no backend).

**Backend:** the app is architected for **Firebase** (Auth + Firestore), but **Firebase is NOT
connected yet**. Everything must run offline against mock/local data sources. Switching to real
Firebase later must be a **DI-only change** (swap one `@LazySingleton(as: ...)` annotation) — no
changes in domain, presentation, or any other layer.

---

## 2. Existing conventions (MUST follow)

### Architecture
```
lib/
  core/                     # shared, feature-agnostic
    constants/              # app_constants, app_dimensions, app_assets
    dependency_injection/   # injection.dart (get_it + injectable), register_module.dart
    errors/                 # exceptions.dart (data layer), failures.dart (domain layer)
    networking/             # dio_client, network_info
    routing/                # app_routes.dart, app_router.dart (go_router)
    theme/                  # app_colors, app_text_styles, app_theme
    utils/                  # usecase.dart, validators.dart
    widgets/                # app_button, app_text_field, app_loading
  modules/<feature>/
    domain/                 # entities/ , repositories/ (abstract) , usecases/
    data/                   # models/ , datasources/ , repositories/ (impl)
    presentation/           # cubit/ , pages/ , widgets/
```

### Hard rules
| Rule | Detail |
|---|---|
| **State management** | `flutter_bloc` **Cubit** only. One `Cubit` + one `State` file per feature area. State is a single `Equatable` class with a `status` enum + `copyWith` (see `auth_state.dart`). **No** `freezed`, no multiple state subclasses. |
| **Error handling** | Data sources `throw` from `core/errors/exceptions.dart`. Repository impls catch them and return `Either<Failure, T>` (`dartz`) using `core/errors/failures.dart`. Cubits use `result.fold(...)`. Domain/presentation never see raw exceptions. |
| **Use cases** | Every repository method is called through a `UseCase<ReturnType, Params>` (see `core/utils/usecase.dart`). Params is an `Equatable` class named `<X>Params`; use `NoParams` when there is no input. |
| **DI** | `injectable` + `get_it`. Annotate: `@injectable` on cubits, `@lazySingleton` on use cases, `@LazySingleton(as: AbstractType)` on repository impls and data source impls. Third-party singletons go in `register_module.dart`. **After adding annotations run:** `dart run build_runner build --delete-conflicting-outputs`. |
| **Routing** | `go_router` via the `AppRouter` singleton. **All paths/names live in `core/routing/app_routes.dart`** — never write a raw route string in a widget. Navigate with `context.goNamed(AppRoutes.xName)` / `context.pushNamed(...)`. |
| **No hardcoded sizes** | Every spacing / radius / size / icon size comes from `AppDimensions`. If a value is missing, **add it to `AppDimensions`** — never inline a number in a widget. |
| **No hardcoded colors** | Every color comes from `AppColors`. Add new ones there. |
| **No hardcoded text styles** | Every `TextStyle` comes from `AppTextStyles` (use `.copyWith(color: ...)` for variants). Add new ones there. |
| **Domain purity** | No `firebase_*`, no `flutter/material.dart`, no `dio` imports anywhere under `domain/`. Entities extend `Equatable`; models (data layer) extend the entity and own the `fromMap` / `toMap` / `fromFirebase` conversions. |
| **Widget size** | Pages stay thin. Any repeated or non-trivial UI block becomes a private/exported widget under `presentation/widgets/`. Prefer `StatelessWidget`. |
| **Imports** | Relative imports inside `lib/` (matches `preferRelativeImports: true`). |
| **Localization** | App locale is `ar` and the app is RTL (see `main.dart`). Design copy is English — keep the English strings from the design, but **never assume LTR layout**: use `EdgeInsetsDirectional`, `start`/`end`, and `Alignment*Start/End`. |

### Existing helper widgets — reuse, don't re-create
- `core/widgets/app_button.dart` → `AppButton(label, onPressed, color, textColor, isLoading)`
- `core/widgets/app_text_field.dart` → `AppTextField(controller, hintText, prefixIcon, obscureText, keyboardType, validator, textInputAction)`
- `core/widgets/app_loading.dart`
- `core/utils/validators.dart` → `Validators.email`, `Validators.password`

---

## 3. What already exists in `modules/authentication` (DO NOT duplicate)

| File | Status |
|---|---|
| `domain/entities/user_entity.dart` | ✅ done (`id`, `email`, `displayName`) |
| `domain/repositories/auth_repository.dart` | ✅ done (`login`, `register`, `logout`, `authStateChanges`, `currentUser`) |
| `domain/usecases/login_usecase.dart` | ✅ done |
| `domain/usecases/logout_usecase.dart` | ✅ done |
| `data/models/user_model.dart` | ✅ done |
| `data/datasources/auth_remote_datasource.dart` | ✅ done — real Firebase impl, **DI annotation commented out on purpose** |
| `data/datasources/mock_auth_remote_datasource.dart` | ✅ done — `@LazySingleton(as: AuthRemoteDataSource)`, the **active** implementation |
| `data/repositories/auth_repository_impl.dart` | ✅ done |
| `presentation/cubit/auth_cubit.dart` + `auth_state.dart` | ✅ exists — **extend** it (see §6) |
| `presentation/pages/login_page.dart` | ⚠️ exists but is a **placeholder UI** — rebuild it to match the design |

**Extend these files; do not rewrite or restructure them.**

---

## 4. Design → screens

### 4.0 Tokens to add first

Add to **`core/theme/app_colors.dart`**:
```dart
static const Color loginBackground = Color(0xFF1400FF); // deep blue login canvas
static const Color accentCyan      = Color(0xFF00E5D0); // focused "Sign in" outline + checkbox
static const Color accentPink      = Color(0xFFFF2D6F); // "Sign up" link + step-5 banner
static const Color facebookSurface = Color(0xFFFFFFFF);
static const Color progressTrack   = Color(0xFFE0E0E0);
static const Color progressFill    = Color(0xFF9E9E9E);
```

Add to **`core/constants/app_dimensions.dart`**:
```dart
static const double progressBarHeight   = 12;
static const double onboardingCardMinH  = 120;
static const double optionRowHeight     = 56;
static const double socialIconSize      = 28;
static const double borderWidthSelected = 2;
static const double borderWidth         = 1;
```

Add to **`core/theme/app_text_styles.dart`** anything missing (e.g. `bodySmall`, `cardTitle`,
`bannerText` — bold white on colored banner). Do not inline styles.

---

### 4.1 Screen 1 — Login  (`/login`)

Full-bleed `AppColors.loginBackground`, `SafeArea`, `SingleChildScrollView`, centered column.

| Element | Spec |
|---|---|
| Title | `"Login"` — `AppTextStyles.headingLarge` white, centered |
| Subtitle | `"You don't think you should login first and behave like human not robot."` — small white, centered, max 2 lines |
| Email field | `AppTextField`, hint `"Email address"`, `Icons.person_outline`, `TextInputType.emailAddress`, `validator: Validators.email` |
| Password field | `AppTextField`, hint `"Password"`, `Icons.lock_outline`, `obscureText: true`, `validator: Validators.password` |
| Row | **left:** `Checkbox` + `"Remember me"` (white text, `accentCyan` when checked). **right:** `"Forgot your password?"` `TextButton`, white text |
| Sign in | `AppButton(label: 'Sign in', color: AppColors.background, textColor: AppColors.textPrimary)` wrapped in a `Container` with a **2px `accentCyan` border** and `radiusMd` |
| Facebook | `AppButton(label: 'Login with Facebook', color: AppColors.facebookSurface, textColor: AppColors.textPrimary)` |
| Social row | Two circular white icon buttons (Twitter, Google+), size `AppDimensions.socialIconSize`, centered |
| Footer | `"Don't have an account? "` white + `"Sign up"` in `accentPink`, tappable |

Behaviour:
- Wrap in `Form` + `GlobalKey<FormState>`; validate on submit.
- `BlocProvider(create: (_) => getIt<AuthCubit>())` at the page root, `BlocConsumer` inside.
- `AuthStatus.loading` → `AppButton.isLoading = true`.
- `AuthStatus.error` → `SnackBar` with `state.errorMessage`.
- `AuthStatus.authenticated` → **navigate per §7**.
- `"Remember me"`, `"Forgot your password?"`, Facebook, Twitter, Google+, `"Sign up"` are **UI-only
  for now**: render them fully, and on tap show a `SnackBar('Coming soon')`. Do **not** stub fake
  backend logic for them.

> **Explicit requirement from the product owner:** pressing **Sign in** must actually enter the app.
> The active `MockAuthRemoteDataSourceImpl` already returns a successful user for any credentials,
> so a valid-format email + 6-char password is enough. Do not add extra gates.

---

### 4.2 Screens 2–6 — Onboarding "Tell us about yourself"

A **single page driving 5 steps** (do not create 5 routes). Shared chrome on every step:

- White background, `SafeArea`.
- **Back arrow** top-start → previous step; on step 1 → `context.pop()` back to login.
- Header `"Tell us about yourself"` — `AppTextStyles.headingMedium`.
- **Segmented progress bar**: `AppDimensions.progressBarHeight`, `radiusSm`, track
  `AppColors.progressTrack`, fill `AppColors.progressFill`, filled fraction = `(step + 1) / 5`.
- **Question banner**: full-width solid colored box, `radiusSm`, bold white text, one per step.

| Step | Banner color | Banner text | Body |
|---|---|---|---|
| 1 | `AppColors.primary` | `Why have you chosen to study Arabic?` | 2-column grid, 5 image cards |
| 2 | `AppColors.levelTashkeel` | `What is your level of proficiency in Arabic?` | 4 full-width option rows |
| 3 | `AppColors.levelNumbers` | `What is your daily goal for learning Arabic?` | 4 rows: goal (start) + label (end) |
| 4 | `AppColors.levelSentences` | `Here's what you can accomplish!` | 3 info cards + `CONTINUE` button |
| 5 | `AppColors.accentPink` | `Now let's find the best place to start!` | 2 cards |

**Step 1 — options** (2-col grid, each card = image on top + caption below, `AppColors.surface`
background, `radiusMd`, `border` outline, selected → `AppColors.primary` outline
`borderWidthSelected`):

| id | Label | Asset |
|---|---|---|
| `future_trips` | Get ready for future trips | `AppAssets.disc` (map placeholder) |
| `connections` | Establish connections | `AppAssets.contacts` |
| `education` | Enhance my educational | `AppAssets.paper` |
| `career` | Advance my career | `AppAssets.stairs` |
| `other` | Other | `AppAssets.sparkle` |

> If an asset file is missing from `assets/images/icons/`, fall back to a Material `Icon` — **do not
> add new asset files** and do not break the build.

**Step 2 — options** (full-width rows, `optionRowHeight`, `AppColors.surface`, `radiusSm`):
`beginner` "I'm a beginner in Arabic" · `few_words` "I know a few words" ·
`conversational` "I can hold conversations" · `intermediate_plus` "I have an intermediate or higher level"

**Step 3 — options** (row: goal text at start, label at end in `textSecondary`):
`10` "10 min/day" — Casual · `15` "15 min/day" — Regular · `20` "20 min/day" — Serious ·
`25` "25 min/day" — Intense

**Step 4 — info cards** (icon at start, title `AppTextStyles.bodyLarge` bold, subtitle
`bodyMedium`). Not selectable — informational only:
1. **Engage in confident conversations** — "Interact with people with less difficulty"
2. **Expand your vocabulary significantly** — "Learn new words that will make you express yourself better"
3. **Cultivate a consistent learning routine** — "Build the healthy habit of learning something new everyday"

Bottom: `AppButton(label: 'CONTINUE')` → step 5.

**Step 5 — cards**:
1. `from_scratch` — **Start from Scratch** / "Let us take you step by step from the beginning." (`AppAssets.paper`)
2. `find_my_place` — **Find my starting place** / "Jump to the level you are currently at." (`AppAssets.magnifier`)

Tapping a card **finishes onboarding** → §7.

**Step behaviour:** selecting an option on steps 1/2/3 stores it in the cubit and **auto-advances**
to the next step. Steps 1/2/3 are single-select. Back navigation preserves previous answers.

---

## 5. Files to create

```
lib/modules/onboarding/
  domain/
    entities/
      onboarding_answers.dart          # Equatable: reason, proficiency, dailyGoalMinutes, startingPoint, isCompleted
      onboarding_option.dart           # Equatable: id, label, assetPath?, trailingLabel?
      onboarding_step.dart             # enum: reason, proficiency, dailyGoal, benefits, startingPoint
    repositories/
      onboarding_repository.dart       # abstract
    usecases/
      get_onboarding_questions_usecase.dart   # UseCase<List<OnboardingQuestion>, NoParams>
      save_onboarding_answers_usecase.dart    # UseCase<Unit, SaveOnboardingParams>
      get_onboarding_status_usecase.dart      # UseCase<bool, NoParams>  (isCompleted)
  data/
    models/
      onboarding_answers_model.dart    # extends entity + fromMap/toMap
    datasources/
      onboarding_local_datasource.dart # abstract + impl: seeded questions & Hive-backed answers
      onboarding_remote_datasource.dart# abstract + FIREBASE impl, DI annotation COMMENTED OUT
      mock_onboarding_remote_datasource.dart # @LazySingleton(as: OnboardingRemoteDataSource) — ACTIVE
    repositories/
      onboarding_repository_impl.dart
  presentation/
    cubit/
      onboarding_cubit.dart
      onboarding_state.dart            # part of onboarding_cubit.dart
    pages/
      onboarding_page.dart
    widgets/
      onboarding_scaffold.dart         # back arrow + header + progress bar + banner
      onboarding_progress_bar.dart
      onboarding_banner.dart
      onboarding_option_card.dart      # grid card (image + caption)
      onboarding_option_row.dart       # full-width row (+ optional trailing label)
      onboarding_benefit_card.dart     # icon + title + subtitle
```

Plus, in `modules/authentication/presentation/widgets/`:
```
login_social_row.dart      # twitter + google+ circles
login_footer.dart          # "Don't have an account? Sign up"
remember_me_row.dart       # checkbox + forgot-password
```

---

## 6. Layer contracts

### 6.1 Domain

```dart
// onboarding_answers.dart
class OnboardingAnswers extends Equatable {
  const OnboardingAnswers({
    this.reason,
    this.proficiency,
    this.dailyGoalMinutes,
    this.startingPoint,
    this.isCompleted = false,
  });

  final String? reason;
  final String? proficiency;
  final int? dailyGoalMinutes;
  final String? startingPoint;
  final bool isCompleted;

  OnboardingAnswers copyWith({...});

  @override
  List<Object?> get props => [reason, proficiency, dailyGoalMinutes, startingPoint, isCompleted];
}
```

```dart
// onboarding_repository.dart
abstract class OnboardingRepository {
  Future<Either<Failure, List<OnboardingQuestion>>> getQuestions();
  Future<Either<Failure, Unit>> saveAnswers(OnboardingAnswers answers);
  Future<Either<Failure, OnboardingAnswers>> getSavedAnswers();
  Future<Either<Failure, bool>> isOnboardingCompleted();
}
```

`OnboardingQuestion` = `{ OnboardingStep step, String bannerText, List<OnboardingOption> options }`
— an entity, `Equatable`, defined in `domain/entities/onboarding_question.dart`.

### 6.2 Data

- **`OnboardingLocalDataSourceImpl`** — `@LazySingleton(as: OnboardingLocalDataSource)`.
  - Returns the seeded questions from §4.2 as `static const` lists (same style as
    `LearningLocalDataSourceImpl._seedLevels`).
  - Persists answers + the `isCompleted` flag in a **Hive box** named `onboarding`
    (`hive` and `hive_flutter` are already dependencies). Open the box in `main()` via
    `Hive.initFlutter()` before `configureDependencies()`.
  - Throws `CacheException` on failure.
- **`OnboardingRemoteDataSourceImpl`** — the Firestore version that writes answers to
  `users/{uid}/onboarding`. Use `AppConstants.usersCollection`. **Leave its
  `@LazySingleton(as: ...)` annotation commented out** exactly like
  `AuthRemoteDataSourceImpl` does, with the comment `// Commented out while Firebase is not linked`.
- **`MockOnboardingRemoteDataSourceImpl`** — `@LazySingleton(as: OnboardingRemoteDataSource)`,
  in-memory no-op that succeeds. This is the **active** binding.
- **`OnboardingRepositoryImpl`** — `@LazySingleton(as: OnboardingRepository)`.
  Local is the source of truth for now; it calls the remote in a `try/catch` that swallows remote
  failures (so nothing breaks while Firebase is off). Maps exceptions → failures.

### 6.3 Presentation

```dart
// onboarding_state.dart  (part of onboarding_cubit.dart)
enum OnboardingStatus { initial, loading, ready, submitting, completed, error }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.questions = const [],
    this.currentStepIndex = 0,
    this.answers = const OnboardingAnswers(),
    this.errorMessage,
  });
  // + copyWith + props
  double get progress => questions.isEmpty ? 0 : (currentStepIndex + 1) / questions.length;
}
```

```dart
@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._getQuestions, this._saveAnswers);

  Future<void> load();
  void selectReason(String id);          // then nextStep()
  void selectProficiency(String id);     // then nextStep()
  void selectDailyGoal(int minutes);     // then nextStep()
  void nextStep();
  void previousStep();
  Future<void> selectStartingPoint(String id); // saves + emits completed
}
```

Same `emit(state.copyWith(...))` + `result.fold(...)` style as `AuthCubit`.

---

## 7. Routing

Add to **`core/routing/app_routes.dart`**:
```dart
static const String onboarding = '/onboarding';
static const String onboardingName = 'onboarding';
```

Register in **`AppRouter`**:
```dart
GoRoute(
  path: AppRoutes.onboarding,
  name: AppRoutes.onboardingName,
  builder: (context, state) => const OnboardingPage(),
),
```

**Prototype flow is a plain linear chain with NO guards / NO `redirect`:**

```
/login  ──Sign in──▶  /onboarding  ──finish step 5──▶  /game/letter?lessonId=l1_alef
```

`AppRouter` takes **no constructor dependencies** and sets `initialLocation: AppRoutes.login`.
There is no `redirect` and no `refreshListenable` — each screen navigates to the next itself:

- **`LoginPage`** — `BlocConsumer` listener, on `AuthStatus.authenticated` →
  `context.goNamed(AppRoutes.onboardingName)`.
- **`OnboardingPage`** — `BlocConsumer` listener, on `OnboardingStatus.completed` →
  `context.goNamed(AppRoutes.letterGameName, queryParameters: {'lessonId': AppConstants.firstLessonId})`.

`MockAuthRemoteDataSourceImpl` starts **signed out** (`UserModel? _user;` with no initializer) so
the app always opens on the Login screen.

**Never navigate to a raw path string** — always `goNamed` with a constant from `AppRoutes`.

> Re-introduce a `redirect` (auth guard + "skip onboarding if already completed") only once real
> Firebase auth is wired. It needs a **synchronous** completed-flag getter on `OnboardingRepository`
> (`isOnboardingCompletedSync`) because a redirect callback cannot `await`.

---

## 8. Firebase readiness checklist

Firebase must remain **fully wired but inert**:
- `main.dart` keeps `// await FirebaseService.init();` commented out. Do **not** uncomment it.
- `register_module.dart` keeps the `FirebaseAuth` / `FirebaseFirestore` / `FirebaseStorage`
  providers commented out. Do **not** uncomment them.
- Real Firebase data source impls exist and compile, but their DI annotations stay commented out.
- **Enabling Firebase later must require only:** uncommenting those blocks, commenting out the
  `@LazySingleton(as: ...)` on the two mock data sources, and re-running `build_runner`.
  **If your implementation requires touching any other file to go live, it is wrong.**

---

## 9. Acceptance criteria

1. `flutter analyze` → **0 errors, 0 warnings**.
2. `dart run build_runner build --delete-conflicting-outputs` regenerates `injection.config.dart`
   cleanly and the new dependencies appear in it.
3. App launches on `/login` showing the **full login design** (all elements from §4.1 present).
4. Entering any valid-format email + a ≥6-char password and pressing **Sign in** enters the app —
   first run lands on the onboarding flow.
5. All 5 onboarding steps render per §4.2; selecting an option on steps 1–3 auto-advances; the back
   arrow returns to the previous step with the previous answer still selected; the progress bar
   grows each step.
6. Completing step 5 lands on the **letter game** (`/game/letter?lessonId=l1_alef`).
7. Onboarding answers persist to Hive. **Store them as a plain `Map`** via
   `OnboardingAnswersModel.toMap()` / `.fromMap()` — Hive cannot `put` an entity directly without a
   generated `TypeAdapter`, and doing so throws `HiveError: Cannot write, unknown type`, which the
   repository swallows into a `Failure` and silently blocks the final navigation.
8. `grep -r "firebase" lib/modules/onboarding/domain lib/modules/authentication/domain` → **no hits**.
9. No hardcoded numeric size, color literal, or inline `TextStyle` anywhere in the new widgets.

---

## 10. Explicitly out of scope

Do **not** implement: real Firebase calls, sign-up screen, forgot-password flow, Facebook/Twitter/
Google sign-in, "Remember me" persistence, unit/widget tests, localization `.arb` files, or any
changes to the `learning` and `games` modules.
