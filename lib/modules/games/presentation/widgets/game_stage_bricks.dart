import '../../../../core/utils/app_imports.dart';

/// Stage indicator tabs above the canvas.
// TODO(product): wire `total`/`completed` to real lesson-stage progress once
// multi-stage lessons are defined; currently a fixed 3-stage placeholder.
class GameStageBricks extends StatelessWidget {
  const GameStageBricks({super.key, this.total = 3, this.completed = 1});

  final int total;
  final int completed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < total; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceXs),
            child: Container(
              width: AppDimensions.gameStageBrickWidth,
              height: AppDimensions.gameStageBrickHeight,
              decoration: BoxDecoration(
                color: i < completed ? AppColors.success : AppColors.brickGrey,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm / 2),
                border: Border.all(color: AppColors.ink, width: AppDimensions.neoBorderWidthSm),
              ),
            ),
          ),
      ],
    );
  }
}
