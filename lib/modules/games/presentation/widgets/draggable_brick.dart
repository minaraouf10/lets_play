import '../../../../core/utils/app_imports.dart';

import '../constants/puzzle_brick_colors.dart';
import 'brick_shape.dart';

/// A brick positioned on the canvas that the player can drag.
/// Locked (placed) bricks render without a [GestureDetector].
class DraggableBrick extends StatelessWidget {
  const DraggableBrick({
    super.key,
    required this.brick,
    required this.topLeft,
    required this.cellPitch,
    required this.isPlaced,
    required this.isDragging,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
  });

  final PuzzleBrick brick;
  final Offset topLeft;
  final double cellPitch;
  final bool isPlaced;
  final bool isDragging;
  final VoidCallback onPanStart;
  final ValueChanged<Offset> onPanUpdate;
  final VoidCallback onPanEnd;

  @override
  Widget build(BuildContext context) {
    final shape = BrickShape(
      cells: brick.cells,
      color: kPuzzleBrickColors[brick.colorIndex % kPuzzleBrickColors.length],
      cellPitch: cellPitch,
    );

    return Positioned(
      left: topLeft.dx * cellPitch,
      top: topLeft.dy * cellPitch,
      child: isPlaced
          ? shape
          : GestureDetector(
              onPanStart: (_) => onPanStart(),
              onPanUpdate: (details) => onPanUpdate(details.delta),
              onPanEnd: (_) => onPanEnd(),
              child: AnimatedScale(
                scale: isDragging ? 1.06 : 1.0,
                duration: const Duration(milliseconds: 100),
                child: shape,
              ),
            ),
    );
  }
}
