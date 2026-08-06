import '../../../../../core/utils/app_imports.dart';

/// Intro step 0: the "Level N — You'll learn ..." objectives card, shown on a
/// flat level-colored background above the CONTINUE button.
class LessonIntroLevelStep extends StatelessWidget {
  const LessonIntroLevelStep({
    super.key,
    required this.levelType,
    required this.objectives,
    required this.onContinue,
  });

  final LevelType levelType;
  final List<String> objectives;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: levelType.color,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textOnColor),
                  onPressed: () => context.pop(),
                ),
              ),
              Expanded(
                child: SvgPicture.asset(
                  levelType.introImage,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              _ObjectivesCard(
                levelNumber: levelType.number,
                badgeColor: levelType.color,
                objectives: objectives,
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
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMd),
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
            ],
          ),
        ),
      ),
    );
  }
}

/// White neo-brutalist card: "Level N" with a badged number, then a checklist
/// of what the level teaches.
class _ObjectivesCard extends StatelessWidget {
  const _ObjectivesCard({
    required this.levelNumber,
    required this.badgeColor,
    required this.objectives,
  });

  final int levelNumber;

  /// Fills the badge around the level number, matching the level's colour.
  final Color badgeColor;
  final List<String> objectives;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceLg),
      decoration: BoxDecoration(
        color: AppColors.background,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Level', style: AppTextStyles.headingLarge),
              const SizedBox(width: AppDimensions.spaceSm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceSm,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppDimensions.neoBorderWidthSm,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                ),
                child: Text(
                  '$levelNumber',
                  style: AppTextStyles.headingLarge.copyWith(
                    color: AppColors.textOnColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceXs),
          Text("You'll learn", style: AppTextStyles.bodyLarge),
          const SizedBox(height: AppDimensions.spaceLg),
          for (final objective in objectives)
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spaceSm),
              child: Row(
                children: [
                  const Icon(
                    Icons.check,
                    size: AppDimensions.iconMd,
                    color: AppColors.ink,
                  ),
                  const SizedBox(width: AppDimensions.spaceMd),
                  Expanded(
                    child: Text(objective, style: AppTextStyles.bodyLarge),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
