import '../../../../core/utils/app_imports.dart';
import '../pages/followers_page.dart';
import 'follower_stat_tile.dart';

/// Modal overlay popup showing follower details: avatar, name, badge, stats.
/// Uses ColoredBox scrim + Center container pattern (NO showDialog).
class FollowerDetailOverlay extends StatelessWidget {
  const FollowerDetailOverlay({
    super.key,
    required this.follower,
    required this.onDismiss,
  });

  final FollowerEntry follower;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.overlayScrim,
      child: Center(
        child: Container(
          width: AppDimensions.overlayCardWidth,
          margin: const EdgeInsets.all(AppDimensions.spaceLg),
          padding: const EdgeInsets.all(AppDimensions.spaceLg),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 24),
                  const Text(
                    'Follower',
                    style: AppTextStyles.headingMedium,
                  ),
                  GestureDetector(
                    onTap: onDismiss,
                    child: const Icon(
                      Icons.close,
                      size: AppDimensions.overlayCloseSize,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              CircleAvatar(
                radius: AppDimensions.profileAvatarMd / 2,
                backgroundColor: AppColors.surface,
                child: const Icon(Icons.person),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              Text(
                follower.name,
                style: AppTextStyles.profileName,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppDimensions.spaceSm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceMd,
                  vertical: AppDimensions.spaceXs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.badgePill,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.badgePillHeight / 2,
                  ),
                ),
                child: Text(
                  'Following',
                  style: AppTextStyles.badgePillLabel,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              Row(
                children: [
                  Expanded(
                    child: FollowerStatTile(
                      label: 'Points',
                      value: '${follower.points}',
                      color: AppColors.statPoints,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceMd),
                  Expanded(
                    child: FollowerStatTile(
                      label: 'Rank',
                      value: '#1',
                      color: AppColors.levelLetters,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
