import '../../../../core/utils/app_imports.dart';
import '../pages/followers_page.dart';

/// Follower list row: avatar + name + points.
class FollowerRow extends StatelessWidget {
  const FollowerRow({
    super.key,
    required this.follower,
    required this.onTap,
  });

  final FollowerEntry follower;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.leaderboardRowHeight,
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceMd,
          vertical: AppDimensions.spaceSm,
        ),
        padding: const EdgeInsets.all(AppDimensions.spaceMd),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(color: AppColors.border, width: 1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.surface,
              child: const Icon(Icons.person),
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(
              child: Text(
                follower.name,
                style: AppTextStyles.bodyLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${follower.points}',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
