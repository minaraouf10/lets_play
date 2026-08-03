import '../../../../core/utils/app_imports.dart';

/// Reset button plus a timer/energy pill.
class GameBottomBar extends StatelessWidget {
  const GameBottomBar({
    super.key,
    required this.secondsLeft,
    required this.energy,
    required this.onReset,
  });

  final int secondsLeft;
  final int energy;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final minutes = (secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (secondsLeft % 60).toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMd,
        vertical: AppDimensions.spaceSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppDimensions.gameResetButtonSize,
            height: AppDimensions.gameResetButtonSize,
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: onReset,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                  side: const BorderSide(
                    color: AppColors.ink,
                    width: AppDimensions.neoBorderWidthSm,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.timer_outlined, size: AppDimensions.iconSm),
              const SizedBox(width: AppDimensions.spaceXs),
              Text('$minutes:$seconds', style: AppTextStyles.bodyMedium),
              const SizedBox(width: AppDimensions.spaceMd),
              const Icon(Icons.bolt_rounded, color: AppColors.coin, size: AppDimensions.iconSm),
              const SizedBox(width: AppDimensions.spaceXs),
              Text('$energy', style: AppTextStyles.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
