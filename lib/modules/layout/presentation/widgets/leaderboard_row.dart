import '../../../../core/utils/app_imports.dart';
import '../pages/leaderboard_page.dart';
import 'rank_badge.dart';

/// One list row: rank badge + avatar + name + points.
/// Highlighted rows have white card + border.
class LeaderboardRow extends StatelessWidget {
  const LeaderboardRow({
    super.key,
    required this.entry,
    required this.onTap,
    this.isHighlighted = false,
  });

  final LeaderboardEntry entry;
  final VoidCallback onTap;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final cardColor = isHighlighted ? AppColors.highlightCard : AppColors.background;
    final borderColor = isHighlighted ? AppColors.border : Colors.transparent;

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
          color: cardColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        child: Row(
          children: [
            RankBadge(rank: entry.rank),
            const SizedBox(width: AppDimensions.spaceMd),
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.surface,
              child: const Icon(Icons.person),
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: AppTextStyles.bodyLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              '${entry.points}',
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
