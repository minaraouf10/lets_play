import 'package:game_test/modules/layout/presentation/pages/followers_page.dart';
import 'package:game_test/modules/layout/presentation/pages/leaderboard_page.dart';

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
            routes: [
              GoRoute(
                path: AppRoutes.leaderboardFollowers,
                name: AppRoutes.leaderboardFollowersName,
                builder: (context, state) => const FollowersPage(),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: AppRoutes.profile,
            name: AppRoutes.profileName,
            builder: (context, state) => const ProfilePage(),
            routes: [
              GoRoute(
                path: AppRoutes.profileSettings,
                name: AppRoutes.profileSettingsName,
                builder: (context, state) => const SettingsPage(),
                routes: [
                  GoRoute(
                    path: AppRoutes.settingsFeedback,
                    name: AppRoutes.settingsFeedbackName,
                    builder: (context, state) => const FeedbackPage(),
                  ),
                  GoRoute(
                    path: AppRoutes.settingsHelp,
                    name: AppRoutes.settingsHelpName,
                    builder: (context, state) => const HelpCenterPage(),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ],
    );
  }
}
