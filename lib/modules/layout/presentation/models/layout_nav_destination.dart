import '../../../../core/constants/app_assets.dart';

/// Static description of one bottom‑nav entry.
/// Order MUST match the branch order in AppShellRoute.build().
class LayoutNavDestination {
  const LayoutNavDestination({required this.asset, required this.label});

  final String asset;
  final String label;

  static const List<LayoutNavDestination> all = [
    LayoutNavDestination(asset: AppAssets.navHome, label: 'Home'),
    LayoutNavDestination(asset: AppAssets.navStar, label: 'Achievements'),
    LayoutNavDestination(asset: AppAssets.navCrown, label: 'Leaderboard'),
    LayoutNavDestination(asset: AppAssets.navEmoji, label: 'Profile'),
  ];
}
