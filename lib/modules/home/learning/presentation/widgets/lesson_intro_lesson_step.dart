import '../../../../../core/utils/app_imports.dart';


class LessonIntroLessonStep extends StatelessWidget {
  const LessonIntroLessonStep({
    super.key,
    required this.levelType,
    required this.lessonNumber,
    required this.onContinue,
  });

  final LevelType levelType;
  final int lessonNumber;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: levelType.gradient),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.ink),
                  onPressed: () => context.pop(),
                ),
              ),
              Expanded(
                child: SvgPicture.asset(AppAssets.lessonImage),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              LessonInfoBox(
                lessonNumber: lessonNumber,
                levelNumber: levelType.number,
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeight,
                child: OutlinedButton(
                  onPressed: onContinue,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    side: const BorderSide(
                      color: AppColors.ink,
                      width: AppDimensions.neoBorderWidth,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    ),
                  ),
                  child: Text(
                    'CONTINUE',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              // AppButton(
              //   label: 'CONTINUE',
              //   textColor:AppColors.textSecondary,
              //   color: AppColors.navBarBackground,
              //   onPressed: onContinue,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
