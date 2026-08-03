import 'dart:math' as math;

import '../../../../core/utils/app_imports.dart';
import '../constants/puzzle_brick_colors.dart';
import 'brick_shape.dart';

/// The letter drawn as empty outlined cells. Dragging across a cell fills it
/// with a brick; a hand cursor follows the finger while tracing.
class TraceCanvas extends StatefulWidget {
  const TraceCanvas({
    super.key,
    required this.puzzle,
    required this.filledCells,
    required this.onTouchCell,
  });

  final LetterPuzzle puzzle;
  final Set<BlockPosition> filledCells;
  final ValueChanged<BlockPosition> onTouchCell;

  @override
  State<TraceCanvas> createState() => _TraceCanvasState();
}

class _TraceCanvasState extends State<TraceCanvas> {
  Offset? _handPosition;

  void _handleTouch(Offset local, double pitch) {
    setState(() => _handPosition = local);
    final cell = BlockPosition(
      (local.dy / pitch).floor(),
      (local.dx / pitch).floor(),
    );
    widget.onTouchCell(cell);
  }

  @override
  Widget build(BuildContext context) {
    final puzzle = widget.puzzle;

    return LayoutBuilder(
      builder: (context, constraints) {
        final pitch = math.min(
          constraints.maxWidth / puzzle.cols,
          constraints.maxHeight / puzzle.rows,
        );
        final width = puzzle.cols * pitch;
        final height = puzzle.rows * pitch;

        return Center(
          child: GestureDetector(
            onPanStart: (d) => _handleTouch(d.localPosition, pitch),
            onPanUpdate: (d) => _handleTouch(d.localPosition, pitch),
            onPanEnd: (_) => setState(() => _handPosition = null),
            onTapDown: (d) => _handleTouch(d.localPosition, pitch),
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  for (final cell in puzzle.target)
                    Positioned(
                      left: cell.col * pitch,
                      top: cell.row * pitch,
                      child: widget.filledCells.contains(cell)
                          ? BrickShape(
                              cells: const [BlockPosition(0, 0)],
                              color: kPuzzleBrickColors[
                                  _colorForCell(puzzle, cell)],
                              cellPitch: pitch,
                            )
                          : _EmptyCell(pitch: pitch),
                    ),
                  if (_handPosition != null)
                    Positioned(
                      left: _handPosition!.dx - AppDimensions.iconLg / 2,
                      top: _handPosition!.dy - AppDimensions.iconLg / 2,
                      child: const Icon(
                        Icons.back_hand,
                        size: AppDimensions.iconLg,
                        color: AppColors.textPrimary,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Colour a traced cell the same as the brick that owns it in the puzzle.
  int _colorForCell(LetterPuzzle puzzle, BlockPosition cell) {
    for (final brick in puzzle.bricks) {
      for (final c in brick.cells) {
        final abs = BlockPosition(
          brick.targetOrigin.row + c.row,
          brick.targetOrigin.col + c.col,
        );
        if (abs == cell) return brick.colorIndex;
      }
    }
    return 0;
  }
}

class _EmptyCell extends StatelessWidget {
  const _EmptyCell({required this.pitch});

  final double pitch;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: pitch - AppDimensions.gameCellGap,
      height: pitch - AppDimensions.gameCellGap,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        border: Border.all(
          color: AppColors.slotOutline,
          width: AppDimensions.neoBorderWidthSm,
        ),
      ),
    );
  }
}
