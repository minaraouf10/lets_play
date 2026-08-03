import '../utils/app_imports.dart';



/// The 4-tab shell. Each branch owns its own Navigator, so a push inside a
/// tab keeps the bottom bar visible and keeps that tab's stack independent.
class AppShellRoute {
  const AppShellRoute._();

  static StatefulShellRoute build() {
    return StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoutes.levels,
            name: AppRoutes.levelsName,
            builder: (context, state) => const LevelsMapPage(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoutes.achievements,
            name: AppRoutes.achievementsName,
            builder: (context, state) => const AchievementsPage(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoutes.leaderboard,
            name: AppRoutes.leaderboardName,
            builder: (context, state) => const LeaderboardPage(),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoutes.profile,
            name: AppRoutes.profileName,
            builder: (context, state) => const ProfilePage(),
          ),
        ]),
      ],
    );
  }
}
