import '../utils/app_imports.dart';

/// Wraps [GoRouter].
///
/// Prototype flow is a plain linear chain with no auth/onboarding guards:
///   /login  ->  /onboarding  ->  /game/letter
/// Each screen navigates to the next itself. Re-introduce a `redirect`
/// here once real Firebase auth is wired.
@lazySingleton
class AppRouter {
  AppRouter() {
    router = GoRouter(
      initialLocation: AppRoutes.splash,
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          name: AppRoutes.splashName,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: AppRoutes.login,
          name: AppRoutes.loginName,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: AppRoutes.onboarding,
          name: AppRoutes.onboardingName,
          builder: (context, state) => const OnboardingPage(),
        ),
        AppShellRoute.build(),
        GoRoute(
          path: AppRoutes.lessonIntro,
          name: AppRoutes.lessonIntroName,
          builder: (context, state) => LessonIntroPage(
            lessonId: state.uri.queryParameters['lessonId'] ?? '',
            levelType: LevelType.values.byName(
              state.uri.queryParameters['levelType'] ?? LevelType.letters.name,
            ),
            lessonNumber:
                int.tryParse(state.uri.queryParameters['lessonNumber'] ?? '') ?? 1,
          ),
        ),
        GoRoute(
          path: AppRoutes.letterGame,
          name: AppRoutes.letterGameName,
          builder: (context, state) => LetterGamePage(
            lessonId: state.uri.queryParameters['lessonId'] ?? '',
          ),
        ),
        GoRoute(
          path: AppRoutes.greatJob,
          name: AppRoutes.greatJobName,
          builder: (context, state) => GreatJobPage(
            lessonId: state.uri.queryParameters['lessonId'] ?? '',
            userName: state.uri.queryParameters['userName'] ?? 'Student',
            nextRouteName: state.uri.queryParameters['nextRoute'],
          ),
        ),
        GoRoute(
          path: AppRoutes.letterReview,
          name: AppRoutes.letterReviewName,
          builder: (context, state) => LetterReviewPage(
            lessonId: state.uri.queryParameters['lessonId'] ?? '',
            letterName: state.uri.queryParameters['letterName'] ?? 'Alef',
          ),
        ),
        GoRoute(
          path: AppRoutes.letterTrace,
          name: AppRoutes.letterTraceName,
          builder: (context, state) => LetterTracePage(
            lessonId: state.uri.queryParameters['lessonId'] ?? '',
          ),
        ),
        GoRoute(
          path: AppRoutes.letterQuiz,
          name: AppRoutes.letterQuizName,
          builder: (context, state) => LetterQuizPage(
            lessonId: state.uri.queryParameters['lessonId'] ?? '',
            letterName: state.uri.queryParameters['letterName'] ?? 'Alif',
          ),
        ),
      ],
    );
  }

  late final GoRouter router;
}
