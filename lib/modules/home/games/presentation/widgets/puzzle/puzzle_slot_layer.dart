import 'package:flutter/foundation.dart' show listEquals;

import '../../../../../../core/utils/app_imports.dart';

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
      // The stud hints reach above their slot, matching where a brick's own
      // studs land once it is dropped in.
      clipBehavior: Clip.none,
      children: [
        for (final brick in bricks)
          if (!filledSlots.containsKey(brick.targetOrigin))
            Positioned(
              left: brick.targetOrigin.col * cellPitch,
              top: brick.targetOrigin.row * cellPitch,
              width: brick.width * cellPitch - AppDimensions.gameCellGap,
              height: brick.height * cellPitch - AppDimensions.gameCellGap,
              child: _Slot(brick: brick, cellPitch: cellPitch),
            ),
      ],
    );
  }
}

/// One empty target: the brick's outline, plus a faint ring where each stud
/// will land, so the slot previews the exact piece that fits it.
class _Slot extends StatelessWidget {
  const _Slot({required this.brick, required this.cellPitch});

  final PuzzleBrick brick;
  final double cellPitch;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SlotPainter(cells: brick.cells, cellPitch: cellPitch),
    );
  }
}

/// Draws the slot the same way [BrickShape] draws a brick — same rounded
/// square, same stud rings — so a dropped piece lands exactly on the outline.
class _SlotPainter extends CustomPainter {
  const _SlotPainter({required this.cells, required this.cellPitch});

  final List<BlockPosition> cells;
  final double cellPitch;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = AppColors.slotOutline
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppDimensions.neoBorderWidthSm;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size,
        const Radius.circular(AppDimensions.gameBrickRadius),
      ),
      stroke,
    );

    final radius = cellPitch * AppDimensions.gameStudDiameterRatio / 2;
    for (final cell in cells) {
      final centre = Offset(
        cell.col * cellPitch + (cellPitch - AppDimensions.gameCellGap) / 2,
        cell.row * cellPitch + (cellPitch - AppDimensions.gameCellGap) / 2,
      );
      canvas.drawCircle(centre, radius, stroke);
    }
  }

  @override
  bool shouldRepaint(_SlotPainter old) =>
      old.cellPitch != cellPitch || !listEquals(old.cells, cells);
}
