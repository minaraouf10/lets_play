import '../../../../core/utils/app_imports.dart';


/// Colored, neo-brutalist banner that heads each level section on the map:
/// solid level color, black border, hard offset shadow (no blur).
class LevelHeader extends StatelessWidget {
  const LevelHeader({super.key, required this.level});

  final LevelEntity level;

  @override
  Widget build(BuildContext context) {
    final color = level.type.color;
    final onColor = level.type.onColor;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        border: Border.all(
          color: AppColors.ink,
          width: AppDimensions.neoBorderWidth,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.ink,
            offset: Offset(
              AppDimensions.neoShadowOffset,
              AppDimensions.neoShadowOffset,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            level.titleEn,
            style: AppTextStyles.headingMedium.copyWith(color: onColor),
          ),
          const SizedBox(height: AppDimensions.spaceXs),
          Text(
            level.description,
            style: AppTextStyles.bodyMedium.copyWith(color: onColor),
          ),
        ],
      ),
    );
  }
}
