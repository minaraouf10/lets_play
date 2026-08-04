import '../../../../core/utils/app_imports.dart';

/// Stat tile for follower detail overlay showing a labeled value in NeoContainer.
class FollowerStatTile extends StatelessWidget {
  const FollowerStatTile({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return NeoContainer(
      color: color,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.statValue,
          ),
          const SizedBox(height: AppDimensions.spaceXs),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textOnColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
