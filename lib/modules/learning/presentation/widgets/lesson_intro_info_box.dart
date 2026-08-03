import '../../../../core/utils/app_imports.dart';


/// Neo-brutalist card showing "Lesson N" (badged) and "Level N" — the info
/// box shown on the first step of the lesson intro flow.
class LessonInfoBox extends StatelessWidget {
  const LessonInfoBox({
    super.key,
    required this.lessonNumber,
    required this.levelNumber,
  });

  final int lessonNumber;
  final int levelNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      decoration: BoxDecoration(
        color: AppColors.splashYellow,
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
                Text('Lesson', style: AppTextStyles.headingMedium),
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
            Text('Level $levelNumber', style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary
            )),
          ],
        ),
      ),
    );
  }
}
