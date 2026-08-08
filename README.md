# Let's Play — Arabic Literacy Learning Game

An offline-first Flutter app that teaches Arabic reading and writing to children
through play: block puzzles, guided tracing, listening quizzes and short lessons,
organised into a five-level curriculum with progress, achievements and a
leaderboard.

The app is built mobile-first (Android + iOS) with a Firebase backend, and is
released as open source under the [MIT License](LICENSE).

---

## Table of contents

- [Screens and learning flow](#screens-and-learning-flow)
- [Architecture](#architecture)
- [Module map](#module-map)
- [Project structure](#project-structure)
- [Tech stack](#tech-stack)
- [Getting started](#getting-started)
- [Testing](#testing)
- [Code conventions](#code-conventions)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

---

## Screens and learning flow

The learner moves through a level map, opens a lesson, and plays a sequence of
game steps that build up one letter, mark, number, word or grammar rule.

```
Splash → Login / Onboarding → Levels map → Lesson intro → Game steps → Lesson complete
                                   ↑                                          │
                                   └──────────── progress, XP, streak ────────┘
```

### Curriculum

| Level | Type          | Content                                                | Status                    |
| ----- | ------------- | ------------------------------------------------------ | ------------------------- |
| 1     | Letters       | The 28 letters, lam-alef and hamza carriers            | Implemented               |
| 2     | Tashkeel      | Short vowels and diacritic marks                        | Implemented               |
| 3     | Numbers       | Arabic numerals, name and sound recognition             | Implemented               |
| 4     | Words         | Word building, image and audio choice                   | Implemented               |
| 5     | Sentences     | Grammar lessons and sentence structure                  | Sample content            |

Levels 1–3 list the full set on the grid so the whole curriculum is visible;
tiles unlock as the matching content is authored in the local data sources.
Adding new lessons is a **data change only** — no new screens required.

### Game types

| Game            | Route                   | What the learner does                                        |
| --------------- | ----------------------- | ------------------------------------------------------------ |
| Block puzzle    | `/game/letter`          | Drags coloured bricks onto a grid to assemble a letter shape |
| Letter review   | `/game/letter-review`   | Sees the glyph, its four positional forms, and its bricks    |
| Tracing         | `/game/letter-trace`    | Traces the letter stroke-by-stroke on a guided canvas        |
| Letter quiz     | `/game/letter-quiz`     | Listens to the letter and picks the correct answer           |
| Number quiz     | `/game/number-quiz`     | Matches numerals to their spoken name                        |
| Word lesson     | `/game/word-lesson`     | Repeats, picks by image, picks by audio, picks by text       |
| Tashkeel lesson | `/game/tashkeel-lesson` | Places marks, matches shapes, builds words                   |
| Grammar lesson  | `/game/grammar-lesson`  | Works through a multi-step grammar explanation and check     |

All routes are declared centrally in [app_routes.dart](lib/core/routing/app_routes.dart)
and wired with `go_router` in [app_router.dart](lib/core/routing/app_router.dart).

---

## Architecture

The client follows **Clean Architecture** with a strict three-layer split per
feature module, and **BLoC/Cubit** for state management.

```
┌──────────────────────────────────────────────────────────────┐
│ Presentation      pages · widgets · cubit + state            │
│                   (Flutter UI, no business rules)            │
├──────────────────────────────────────────────────────────────┤
│ Domain            entities · repository interfaces · usecases│
│                   (pure Dart, no Flutter, no packages)       │
├──────────────────────────────────────────────────────────────┤
│ Data              models · datasources · repository impls    │
│                   (Firebase, Hive, Dio, local seed data)     │
└──────────────────────────────────────────────────────────────┘
```

**Rules that keep the layers honest:**

- Dependencies point **inward only**. Presentation knows Domain; Domain knows
  nothing about the other two.
- Repository *interfaces* live in Domain; their *implementations* live in Data.
  Presentation talks to the interface, never the implementation.
- Errors cross layers as `Either<Failure, T>` (`dartz`), so failures are values
  the UI must handle — not exceptions that can be silently dropped. See
  [failures.dart](lib/core/errors/failures.dart).
- Dependency injection is compile-time generated with `get_it` + `injectable`,
  so the graph is explicit and testable. See
  [injection.dart](lib/core/dependency_injection/injection.dart).

### Client / server split

| Side                 | Responsibility                                                                             |
| -------------------- | ------------------------------------------------------------------------------------------ |
| **Client (Flutter)** | All gameplay, rendering, puzzle/trace verification, TTS, curriculum content, offline cache  |
| **Server (Firebase)**| Auth, user profiles, progress sync, achievements, leaderboard, asset storage                |

The app is **offline-first**: the curriculum ships with the binary as local seed
data, so lessons are fully playable with no connection. Firebase is used for
identity and for syncing progress once the device is online — connectivity is
checked via `internet_connection_checker_plus` and surfaced through
[network_info.dart](lib/core/networking/network_info.dart).

---

## Module map

The repository implements the planned module breakdown as follows:

| #  | Planned module         | Where it lives                                                              |
| -- | ---------------------- | --------------------------------------------------------------------------- |
| 01 | Application Architecture | [lib/core/](lib/core/) — DI, routing, theme, errors, networking            |
| 02 | Block Game Engine      | [widgets/puzzle/](lib/modules/home/games/presentation/widgets/puzzle/) — brick shapes, drag-drop, slot matching |
| 03 | Draw Engine            | [trace_canvas.dart](lib/modules/home/games/presentation/widgets/puzzle/trace_canvas.dart) + `letter_trace_cubit` |
| 04 | Pronunciation Engine   | [letter_audio_service.dart](lib/core/services/letter_audio_service.dart) — TTS playback (speech verification pending) |
| 05 | Quiz Module            | [widgets/quiz/](lib/modules/home/games/presentation/widgets/quiz/), `letter_quiz` / `number_quiz` cubits |
| 06 | Profile Module         | [modules/profile/](lib/modules/profile/) + [modules/authentication/](lib/modules/authentication/) |
| 07 | Leaderboard            | [modules/leaderboard/](lib/modules/leaderboard/)                            |
| 08 | Application UI & Flow  | [modules/layout/](lib/modules/layout/), [modules/splash/](lib/modules/splash/), [modules/onboarding/](lib/modules/onboarding/), [core/routing/](lib/core/routing/) |
| 09 | Backend (server side)  | Firebase — [firebase_service.dart](lib/core/services/firebase_service.dart) |

---

## Project structure

```
lib/
├── core/                          # Cross-cutting infrastructure
│   ├── constants/                 # Asset paths, dimensions, app constants
│   ├── dependency_injection/      # get_it + injectable wiring
│   ├── errors/                    # Failure and Exception types
│   ├── networking/                # Dio client, connectivity
│   ├── routing/                   # go_router config, route names, shell
│   ├── services/                  # Firebase, letter audio (TTS)
│   ├── theme/                     # Colors, text styles, ThemeData
│   ├── utils/                     # Shared imports, usecase base, validators
│   └── widgets/                   # Reusable UI primitives
└── modules/
    ├── achievements/              # Badges and rewards
    ├── authentication/            # Sign in / sign up
    ├── home/
    │   ├── games/                 # All playable game types (the core engine)
    │   └── learning/              # Levels map, lesson intro, curriculum data
    ├── layout/                    # Bottom nav shell
    ├── leaderboard/               # Rankings and followers
    ├── onboarding/                # First-run experience
    ├── profile/                   # User profile and settings
    └── splash/                    # Launch screen

test/                              # Widget and unit tests
docs/features/                     # Per-feature specifications
assets/                            # Fonts, images, level artwork
```

Every feature module repeats the same `data / domain / presentation` shape, so
a developer who learns one module can navigate all of them.

---

## Tech stack

| Concern            | Choice                                    |
| ------------------ | ----------------------------------------- |
| Framework          | Flutter 3.41+ / Dart SDK 3.11+            |
| State management   | `flutter_bloc` (Cubit)                    |
| Navigation         | `go_router` (with shell routes)           |
| Dependency injection | `get_it` + `injectable`                 |
| Backend            | Firebase (Auth, Firestore, Storage)       |
| Local storage      | `hive` / `hive_flutter`                   |
| Networking         | `dio`                                     |
| Error handling     | `dartz` (`Either<Failure, T>`), `equatable` |
| Text-to-speech     | `flutter_tts`                             |
| Linting            | `flutter_lints`                           |

**Fonts.** Latin text uses Gotham Rounded; Arabic uses Noto Sans Arabic as the
declared fallback family, because Gotham ships no Arabic glyphs. The mapping is
defined in `pubspec.yaml` and applied in
[app_text_styles.dart](lib/core/theme/app_text_styles.dart).

---

## Getting started

### Prerequisites

- Flutter SDK **3.41.7** or newer (stable channel)
- Dart SDK **3.11.5** or newer (bundled with Flutter)
- Android Studio / Xcode for device tooling
- A Firebase project (for auth, progress sync and leaderboard)

### Setup

```bash
# 1. Clone
git clone https://github.com/minaraouf10/lets_play.git
cd lets_play

# 2. Install dependencies
flutter pub get

# 3. Generate DI code (required — injection.config.dart is generated)
dart run build_runner build --delete-conflicting-outputs

# 4. Run
flutter run
```

### Firebase configuration

Firebase config files are **not committed**. To run against your own project:

1. Create a project in the [Firebase console](https://console.firebase.google.com/).
2. Register an Android app and place `google-services.json` in `android/app/`.
3. Register an iOS app and place `GoogleService-Info.plist` in `ios/Runner/`.
4. Enable **Authentication**, **Cloud Firestore** and **Storage**.

The lessons themselves are local seed data, so the learning flow runs even
before Firebase is configured.

### Useful commands

```bash
flutter analyze                    # Static analysis
flutter test                       # Run the test suite
flutter build apk --release        # Android release build
flutter build ios --release        # iOS release build
dart run build_runner watch        # Regenerate DI on change
dart run flutter_native_splash:create   # Regenerate the native splash screen
```

---

## Testing

Tests live in [test/](test/) and cover the engine logic and the curriculum data
that the UI depends on:

| Test file                  | Covers                                             |
| -------------------------- | -------------------------------------------------- |
| `brick_shape_test.dart`    | Puzzle brick geometry and rendering                |
| `puzzle_canvas_test.dart`  | Drag-drop placement and slot matching              |
| `letter_forms_data_test.dart` | Letter positional-form data integrity           |
| `learning_catalogue_test.dart` | Level/lesson catalogue consistency             |
| `grammar_lesson_test.dart` | Grammar lesson flow                                |
| `number_quiz_test.dart`    | Number quiz answer checking                        |
| `fonts_test.dart`          | Every font declared in `pubspec.yaml` exists on disk |

Run them with:

```bash
flutter test
```

Data-integrity tests like `fonts_test.dart` and `learning_catalogue_test.dart`
exist deliberately: most content bugs in this app come from a data file and an
asset drifting apart, and those failures are cheaper to catch in CI than on a
device.

---

## Code conventions

- **Layer boundaries are not optional.** Business rules go in Domain use cases,
  never in a widget or a Cubit.
- **One Cubit per screen or flow**, with an explicit, `Equatable` state class.
- **No raw strings for routes or assets** — use `AppRoutes` and `AppAssets`.
- **No magic numbers in layout** — use `AppDimensions`.
- **Widgets stay small and are extracted by concern** into
  `presentation/widgets/<area>/`, so each file is reviewable on one screen.
- Run `flutter analyze` before committing; the project uses `flutter_lints`.

---

## Roadmap

- [x] Levels 1–4 lesson and quiz flows
- [x] Block puzzle and tracing engines
- [x] Text-to-speech playback for letters, numbers and words
- [x] Achievements and leaderboard modules
- [ ] Speech **recognition** for pronunciation verification. Engine 04 currently
      handles playback only; the microphone button on the word-repeat step is a
      deliberate UI placeholder with a timed visual state and no scoring behind
      it — see [word_mic_button.dart](lib/modules/home/games/presentation/widgets/word/word_mic_button.dart)
- [ ] Full Level 5 (sentences) content
- [ ] Progress sync and real-time analytics dashboard
- [ ] Social sign-in (Google / Apple)
- [ ] Expanded automated test coverage across all modules

---

## Contributing

1. Branch from `dev`.
2. Keep changes inside one module where possible, and respect the layer split.
3. Add or update tests for any data file or engine logic you touch.
4. Ensure `flutter analyze` and `flutter test` pass.
5. Open a pull request against `dev` describing the change and how you verified it.

---

## License

Released under the **MIT License** — see [LICENSE](LICENSE) for the full text.

You are free to use, modify and distribute this software, including
commercially, provided the copyright notice and permission notice are retained.
