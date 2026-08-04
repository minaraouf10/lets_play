import '../../../../core/utils/app_imports.dart';

/// Small colored square with rank number inside.
/// Color by rank band: gold (1st), silver (2nd), bronze (3rd), gray (4+).
class RankBadge extends StatelessWidget {
  const RankBadge({super.key, required this.rank});

  final int rank;

  Color _getRankColor() {
    return switch (rank) {
      1 => AppColors.podiumFirst,
      2 => AppColors.podiumSecond,
      3 => AppColors.podiumThird,
      _ => AppColors.rankBadgeDefault,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.rankBadgeSize,
      height: AppDimensions.rankBadgeSize,
      decoration: BoxDecoration(
        color: _getRankColor(),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      ),
      child: Center(
        child: Text(
          '$rank',
          style: AppTextStyles.rankBadgeLabel,
        ),
      ),
    );
  }
}
