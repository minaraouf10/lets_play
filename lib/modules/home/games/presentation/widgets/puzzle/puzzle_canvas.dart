import '../../../../../../core/utils/app_imports.dart';

import '../../cubit/letter_game_cubit.dart';
import 'draggable_brick.dart';
import 'puzzle_dot_grid.dart';
import 'puzzle_slot_layer.dart';

/// The build surface: dot-grid background, empty target slots, and every
/// draggable brick. Owns pixel<->cell coordinate math and drag clamping.
///
/// The background fills all the space the parent gives it — full screen width
/// and whatever height is left below the bars — while the letter itself is
/// centred inside that area. Bricks are positioned relative to the letter, not
/// the screen, so the drag and snap maths stay in the letter's own coordinates.
class PuzzleCanvas extends StatelessWidget {
  const PuzzleCanvas({super.key, required this.puzzle, required this.state});

  final LetterPuzzle puzzle;
  final LetterGameState state;

  static double get cellPitch =>
      AppDimensions.gameCellSize + AppDimensions.gameCellGap;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LetterGameCubit>();
    final width = puzzle.cols * cellPitch;
    final height = puzzle.rows * cellPitch;

    return SizedBox.expand(
      child: ClipRect(
        child: CustomPaint(
          // Painted across the whole surface, so the dots read as the page's
          // background rather than a panel behind the letter.
          painter: const PuzzleDotGrid(),
          child: Center(
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  PuzzleSlotLayer(
                    bricks: puzzle.bricks,
                    filledSlots: state.filledSlots,
                    cellPitch: cellPitch,
                  ),
                  for (final brick in puzzle.bricks)
                    if (state.draggingId != brick.id)
                      _buildBrick(context, cubit, brick),
                  // The dragged brick is built last so it renders above the
                  // others instead of sliding underneath them.
                  if (state.draggingId != null)
                    _buildBrick(
                      context,
                      cubit,
                      puzzle.bricks.firstWhere(
                        (b) => b.id == state.draggingId,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrick(
    BuildContext context,
    LetterGameCubit cubit,
    PuzzleBrick brick,
  ) {
    final isPlaced = state.placedIds.contains(brick.id);
    final pos = state.positions[brick.id] ?? Offset.zero;

    return DraggableBrick(
      key: ValueKey(brick.id),
      brick: brick,
      topLeft: pos,
      cellPitch: cellPitch,
      isPlaced: isPlaced,
      isDragging: state.draggingId == brick.id,
      onPanStart: () => cubit.startDrag(brick.id),
      onPanUpdate: (delta) {
        final maxDx = (puzzle.cols - brick.width).toDouble();
        final maxDy = (puzzle.rows - brick.height).toDouble();
        final current = state.positions[brick.id] ?? Offset.zero;
        final proposed = current + delta / cellPitch;
        final clamped = Offset(
          proposed.dx.clamp(0.0, maxDx < 0 ? 0.0 : maxDx),
          proposed.dy.clamp(0.0, maxDy < 0 ? 0.0 : maxDy),
        );
        cubit.updateDrag(brick.id, clamped - current);
      },
      onPanEnd: () => cubit.endDrag(brick.id),
    );
  }
}
