import '../../../../core/utils/app_imports.dart';
import '../../../profile/presentation/widgets/profile_avatar.dart';
import '../../../profile/presentation/widgets/stat_tiles_row.dart';
import '../../domain/entities/follower_entry.dart';

/// Modal overlay showing follower details: avatar, name, badge pill, stat tiles.
/// Uses a ColoredBox scrim + centered card (no showDialog) so it composes
/// inside the shell without covering the bottom nav.
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
    return GestureDetector(
      onTap: onDismiss,
      child: ColoredBox(
        color: AppColors.overlayScrim,
        child: Center(
          child: GestureDetector(
            onTap: () {},
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkResponse(
                      onTap: onDismiss,
                      radius: AppDimensions.navBarTapRadius,
                      child: const Icon(
                        Icons.close,
                        size: AppDimensions.overlayCloseSize,
                      ),
                    ),
                  ),
                  ProfileAvatar(
                    radius: AppDimensions.profileAvatarMd / 2,
                    asset: follower.avatarAsset,
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  Text(
                    follower.name,
                    style: AppTextStyles.profileName,
                    textAlign: TextAlign.center,
                  ),
                  if (follower.badgeLabel != null) ...[
                    const SizedBox(height: AppDimensions.spaceSm),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.spaceMd,
                        vertical: AppDimensions.spaceXs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.badgePill,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusSm,
                        ),
                      ),
                      child: Text(
                        follower.badgeLabel!,
                        style: AppTextStyles.badgePillLabel,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppDimensions.spaceLg),
                  StatTilesRow(stats: follower.stats),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
