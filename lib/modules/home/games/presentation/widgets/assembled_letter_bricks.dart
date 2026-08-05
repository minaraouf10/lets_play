import 'dart:math' as math;

import '../../../../../core/utils/app_imports.dart';
import '../constants/puzzle_brick_colors.dart';
import 'brick_shape.dart';

/// Static picture of bricks assembled at their target positions. Not
/// draggable — used to show a finished letter or one of its positional forms.
class AssembledLetterBricks extends StatelessWidget {
  const AssembledLetterBricks({
    super.key,
    required this.bricks,
    required this.rows,
    required this.cols,
  });

  /// Convenience constructor for a completed puzzle.
  AssembledLetterBricks.puzzle(LetterPuzzle puzzle, {Key? key})
      : this(
          key: key,
          bricks: puzzle.bricks,
          rows: puzzle.rows,
          cols: puzzle.cols,
        );

  final List<PuzzleBrick> bricks;
  final int rows;
  final int cols;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final pitch = math.min(
          constraints.maxWidth / cols,
          constraints.maxHeight / rows,
        );
        return Center(
          child: SizedBox(
            width: cols * pitch,
            height: rows * pitch,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (final brick in bricks)
                  Positioned(
                    left: brick.targetOrigin.col * pitch,
                    top: brick.targetOrigin.row * pitch,
                    child: BrickShape(
                      cells: brick.cells,
                      color: kPuzzleBrickColors[brick.colorIndex],
                      cellPitch: pitch,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
