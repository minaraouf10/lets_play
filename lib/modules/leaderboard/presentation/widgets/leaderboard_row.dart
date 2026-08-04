import '../../../../core/utils/app_imports.dart';
import '../../../profile/presentation/widgets/profile_avatar.dart';
import '../../domain/entities/leaderboard_entry.dart';
import 'rank_badge.dart';

/// One list row: avatar + name + points + [RankBadge].
/// Highlighted rows (the current user) get a white card + border.
class LeaderboardRow extends StatelessWidget {
  const LeaderboardRow({super.key, required this.entry, this.onTap});

  final LeaderboardEntry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      child: Container(
        height: AppDimensions.leaderboardRowHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
        decoration: entry.isCurrentUser
            ? BoxDecoration(
                color: AppColors.highlightCard,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                border: Border.all(color: AppColors.border),
              )
            : null,
        child: Row(
          children: [
            ProfileAvatar(radius: AppDimensions.profileAvatarSm / 2, asset: entry.avatarAsset),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(child: Text(entry.name, style: AppTextStyles.linkRowLabel)),
            Text('${entry.points}', style: AppTextStyles.bodyMedium),
            const SizedBox(width: AppDimensions.spaceMd),
            RankBadge(rank: entry.rank),
          ],
        ),
      ),
    );
  }
}
