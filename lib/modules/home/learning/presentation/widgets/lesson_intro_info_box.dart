import '../../../../../core/utils/app_imports.dart';


/// Neo-brutalist card showing "Lesson N" (badged) and "Level N" — the info
/// box shown on the first step of the lesson intro flow.
class LessonInfoBox extends StatelessWidget {
  const LessonInfoBox({
    super.key,
    required this.lessonNumber,
    required this.levelNumber,
    this.color,
    this.textColor,
  });

  final int lessonNumber;
  final int levelNumber;

  /// Card fill. Defaults to the brand yellow used by Levels 1–3.
  final Color? color;

  /// Text colour on the card. Defaults to dark ink for the yellow fill.
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final onCard = textColor ?? AppColors.textPrimary;

    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: color ?? AppColors.splashYellow,
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
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lesson',
                  style: AppTextStyles.headingMedium.copyWith(color: onCard),
                ),
                const SizedBox(width: AppDimensions.spaceSm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceSm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    border: Border.all(
                      color: AppColors.ink,
                      width: AppDimensions.neoBorderWidthSm,
                    ),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  ),
                  child: Text('$lessonNumber', style: AppTextStyles.headingMedium),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spaceXs),
            Text(
              'Level $levelNumber',
              style: AppTextStyles.bodyMedium.copyWith(color: onCard),
            ),
          ],
        ),
      ),
    );
  }
}
