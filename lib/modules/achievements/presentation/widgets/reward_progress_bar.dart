import '../../../../core/utils/app_imports.dart';

class RewardProgressBar extends StatelessWidget {
  const RewardProgressBar({super.key,
    required this.progress,
    this.color = AppColors.success,
  });

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.rewardProgressHeight),
      child: SizedBox(
        height: AppDimensions.rewardProgressHeight,
        child: Stack(
          children: [
            Container(color: AppColors.progressTrack),
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
