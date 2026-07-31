import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../modules/learning/presentation/pages/levels_map_page.dart';
import '../../modules/authentication/presentation/pages/login_page.dart';
import '../../modules/splash/presentation/pages/splash_page.dart';
import '../../modules/games/presentation/pages/letter_game_page.dart';
import '../../modules/onboarding/presentation/pages/onboarding_page.dart';
import 'app_routes.dart';

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
        GoRoute(
          path: AppRoutes.levels,
          name: AppRoutes.levelsName,
          builder: (context, state) => const LevelsMapPage(),
        ),
        GoRoute(
          path: AppRoutes.letterGame,
          name: AppRoutes.letterGameName,
          builder: (context, state) => LetterGamePage(
            lessonId: state.uri.queryParameters['lessonId'] ?? '',
          ),
        ),
      ],
    );
  }

  late final GoRouter router;
}
