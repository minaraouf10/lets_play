import '../../../../../core/utils/app_imports.dart';

/// Dashed/outlined target slots for bricks that are not yet placed.
class PuzzleSlotLayer extends StatelessWidget {
  const PuzzleSlotLayer({
    super.key,
    required this.bricks,
    required this.filledSlots,
    required this.cellPitch,
  });

  final List<PuzzleBrick> bricks;

  /// Slot origins already occupied; those outlines are hidden.
  final Map<BlockPosition, String> filledSlots;
  final double cellPitch;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (final brick in bricks)
          if (!filledSlots.containsKey(brick.targetOrigin))
            Positioned(
              left: brick.targetOrigin.col * cellPitch,
              top: brick.targetOrigin.row * cellPitch,
              width: brick.width * cellPitch - AppDimensions.gameCellGap,
              height: brick.height * cellPitch - AppDimensions.gameCellGap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.slotOutline,
                    width: AppDimensions.neoBorderWidthSm,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                ),
              ),
            ),
      ],
    );
  }
}
