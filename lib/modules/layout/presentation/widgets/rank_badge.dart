import '../../../../core/utils/app_imports.dart';

/// Circular badge showing rank number in top-left corner of row.
class RankBadge extends StatelessWidget {
  const RankBadge({super.key, required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimensions.rankBadgeSize,
      height: AppDimensions.rankBadgeSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.rankBadgeDefault,
        border: Border.all(
          color: AppColors.ink,
          width: AppDimensions.neoBorderWidthSm,
        ),
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
