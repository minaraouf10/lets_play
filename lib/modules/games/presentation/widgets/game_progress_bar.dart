import '../../../../core/utils/app_imports.dart';

/// Segmented pill showing puzzle completion (0..1).
class GameProgressBar extends StatelessWidget {
  const GameProgressBar({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.gameProgressHeight),
      child: SizedBox(
        height: AppDimensions.gameProgressHeight,
        child: Stack(
          children: [
            Container(color: AppColors.progressTrack),
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(color: AppColors.success),
            ),
          ],
        ),
      ),
    );
  }
}
