import '../../../../core/utils/app_imports.dart';
import '../../../profile/presentation/widgets/profile_avatar.dart';
import '../../domain/entities/follower_entry.dart';

/// Follower list row: avatar + name + points with a trailing star glyph.
class FollowerRow extends StatelessWidget {
  const FollowerRow({super.key, required this.follower, required this.onTap});

  final FollowerEntry follower;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: SizedBox(
        height: AppDimensions.leaderboardRowHeight,
        child: Row(
          children: [
            ProfileAvatar(
              radius: AppDimensions.profileAvatarSm / 2,
              asset: follower.avatarAsset,
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(
              child: Text(
                follower.name,
                style: AppTextStyles.linkRowLabel,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text('${follower.points}', style: AppTextStyles.bodyMedium),
            const SizedBox(width: AppDimensions.spaceSm),
            SvgPicture.asset(
              AppAssets.navStar,
              width: AppDimensions.statTileIconSize,
              height: AppDimensions.statTileIconSize,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
