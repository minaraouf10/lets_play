import '../../../../../core/utils/app_imports.dart';

/// Renders one brick as a single fused piece: one rounded body spanning all
/// [cells], with one stud per cell on top. A 1x2 brick therefore reads as two
/// studs on one solid piece, never as two separate cubes.
///
/// Geometry uses the grid [cellPitch] so a multi-cell brick lines up exactly
/// with the canvas slots, while the visible body is inset by the grid gap.
class BrickShape extends StatelessWidget {
  const BrickShape({
    super.key,
    required this.cells,
    required this.color,
    required this.cellPitch,
  });

  final List<BlockPosition> cells;
  final Color color;
  final double cellPitch;

  @override
  Widget build(BuildContext context) {
    if (cells.isEmpty) return const SizedBox.shrink();

    final maxRow = cells.map((c) => c.row).reduce((a, b) => a > b ? a : b);
    final maxCol = cells.map((c) => c.col).reduce((a, b) => a > b ? a : b);

    // Span every cell's pitch, minus the trailing gap, so the piece fills its
    // footprint without overlapping the next grid slot.
    final width = (maxCol + 1) * cellPitch - AppDimensions.gameCellGap;
    final height = (maxRow + 1) * cellPitch - AppDimensions.gameCellGap;
    final studOffset = (cellPitch - AppDimensions.gameStudSize) / 2;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Single fused body for the whole brick.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                border: Border.all(
                  color: Color.lerp(color, Colors.black, 0.28)!,
                  width: AppDimensions.neoBorderWidthSm,
                ),
              ),
            ),
          ),
          // Darkened bottom lip, inset so the body's rounded corners stay clean.
          Positioned(
            left: AppDimensions.spaceXs,
            right: AppDimensions.spaceXs,
            bottom: AppDimensions.neoBorderWidthSm,
            height: AppDimensions.neoBorderWidthSm,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Color.lerp(color, Colors.black, 0.22),
                borderRadius: BorderRadius.circular(
                  AppDimensions.neoBorderWidthSm,
                ),
              ),
            ),
          ),
          // One stud per cell, centred in its cell.
          for (final cell in cells)
            Positioned(
              left: cell.col * cellPitch + studOffset,
              top: cell.row * cellPitch + studOffset,
              child: Container(
                width: AppDimensions.gameStudSize,
                height: AppDimensions.gameStudSize,
                decoration: BoxDecoration(
                  color: Color.lerp(color, Colors.white, 0.45),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color.lerp(color, Colors.black, 0.15)!,
                    width: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
