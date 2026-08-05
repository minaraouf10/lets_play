import '../../../../../core/utils/app_imports.dart';
import '../../domain/entities/lesson_result.dart';

/// Celebration screen shown when a lesson is finished, reporting the points
/// earned plus the accuracy and time taken.
class LessonCompletePage extends StatelessWidget {
  const LessonCompletePage({
    super.key,
    required this.userName,
    required this.result,
    required this.levelType,
    this.onContinue,
  });

  final String userName;
  final LessonResult result;
  final LevelType levelType;

  /// Where CONTINUE goes. Defaults to popping back to the levels map.
  final VoidCallback? onContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: levelType.celebrationGradient),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimensions.spaceSm,
                    top: AppDimensions.spaceSm,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textOnColor),
                    onPressed: () => _leave(context),
                  ),
                ),
              ),
              _PointsBadge(points: result.points),
              const SizedBox(height: AppDimensions.spaceLg),
              Text(
                'Congratulations $userName!',
                textAlign: TextAlign.center,
                style: AppTextStyles.headingMedium.copyWith(
                  color: AppColors.textOnColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: AppDimensions.spaceXs),
              Text(
                "You've just leveled up!",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textOnColor,
                ),
              ),
              Expanded(
                child: Image.asset(
                  AppAssets.greatJobCharacter,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceMd,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        label: 'Accuracy',
                        value: '${result.accuracyPercent}%',
                        icon: Icons.check,
                        iconColor: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spaceSm),
                    Expanded(
                      child: _StatCard(
                        label: 'Speed',
                        value: result.formattedTime,
                        icon: Icons.hourglass_bottom,
                        iconColor: AppColors.coin,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.spaceSm),
                    Expanded(
                      child: _StatCard(
                        label: 'Share',
                        value: '',
                        icon: Icons.share,
                        iconColor: AppColors.coin,
                        onTap: () => context.showComingSoon(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.spaceMd),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceMd),
                child: SizedBox(
                  width: double.infinity,
                  height: AppDimensions.buttonHeight,
                  child: OutlinedButton(
                    onPressed: () => _leave(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      side: const BorderSide(
                        color: AppColors.ink,
                        width: AppDimensions.neoBorderWidth,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSm),
                      ),
                    ),
                    child: Text(
                      'CONTINUE',
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.textPrimary,
                        letterSpacing: 1.5,
                      ),
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

  void _leave(BuildContext context) {
    if (onContinue != null) {
      onContinue!();
      return;
    }
    context.goNamed(AppRoutes.levelsName);
  }
}

/// The star + total points pill at the top.
class _PointsBadge extends StatelessWidget {
  const _PointsBadge({required this.points});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceLg,
        vertical: AppDimensions.spaceSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(
          color: AppColors.ink,
          width: AppDimensions.neoBorderWidth,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.navStar,
            width: AppDimensions.iconMd,
            height: AppDimensions.iconMd,
          ),
          const SizedBox(width: AppDimensions.spaceSm),
          Text('$points pt', style: AppTextStyles.headingMedium),
        ],
      ),
    );
  }
}

/// One of the three outcome tiles along the bottom.
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.spaceSm,
          horizontal: AppDimensions.spaceXs,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: Border.all(
            color: AppColors.ink,
            width: AppDimensions.neoBorderWidthSm,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceXs),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: AppDimensions.iconMd, color: iconColor),
                if (value.isNotEmpty) ...[
                  const SizedBox(width: AppDimensions.spaceXs),
                  Flexible(
                    child: Text(
                      value,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
