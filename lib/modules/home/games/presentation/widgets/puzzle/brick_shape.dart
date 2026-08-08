import 'package:flutter/foundation.dart' show listEquals;

import '../../../../../../core/utils/app_imports.dart';

/// Renders one brick as a single fused piece: one flat body spanning all
/// [cells], with one stud drawn on the face of each. A 1x2 brick therefore
/// reads as two studs on one physical piece, never as two separate cubes.
///
/// The brick is seen straight-on, so a stud is a ring on the face rather than
/// a cylinder standing above it. Everything is painted inside the widget's
/// layout box, which measures exactly the brick's cells — that is what every
/// `Positioned` and snap calculation on the canvas depends on.
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

    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _BrickPainter(
          cells: cells,
          color: color,
          cellPitch: cellPitch,
        ),
      ),
    );
  }
}

/// Paints the flat brick face: a solid rounded-square body, a darker outline,
/// and one ringed stud centred in every cell.
class _BrickPainter extends CustomPainter {
  const _BrickPainter({
    required this.cells,
    required this.color,
    required this.cellPitch,
  });

  final List<BlockPosition> cells;
  final Color color;
  final double cellPitch;

  @override
  void paint(Canvas canvas, Size size) {
    // A real brick face is one flat plastic colour. The only darker tones are
    // the outline and the thin ring around each stud.
    final outline = Color.lerp(color, Colors.black, 0.20)!;
    final ring = Color.lerp(color, Colors.black, 0.16)!;

    final body = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(AppDimensions.gameBrickRadius),
    );

    canvas.drawRRect(body, Paint()..color = color);
    canvas.drawRRect(
      body,
      Paint()
        ..color = outline
        ..style = PaintingStyle.stroke
        ..strokeWidth = AppDimensions.neoBorderWidthSm,
    );

    final radius = cellPitch * AppDimensions.gameStudDiameterRatio / 2;
    final ringPaint = Paint()
      ..color = ring
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppDimensions.gameStudRingWidth;

    for (final cell in cells) {
      // Centre of the cell, measured from the body's own top-left. The gap is
      // halved because the body already gave up its trailing half.
      final centre = Offset(
        cell.col * cellPitch + (cellPitch - AppDimensions.gameCellGap) / 2,
        cell.row * cellPitch + (cellPitch - AppDimensions.gameCellGap) / 2,
      );
      canvas.drawCircle(centre, radius, ringPaint);
    }
  }

  @override
  bool shouldRepaint(_BrickPainter old) =>
      old.color != color ||
      old.cellPitch != cellPitch ||
      !listEquals(old.cells, cells);
}
