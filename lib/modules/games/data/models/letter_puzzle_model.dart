import '../../domain/entities/block_position.dart';
import '../../domain/entities/letter_puzzle.dart';
import '../../domain/entities/puzzle_brick.dart';

class LetterPuzzleModel extends LetterPuzzle {
  const LetterPuzzleModel({
    required super.lessonId,
    required super.glyph,
    required super.transliteration,
    required super.rows,
    required super.cols,
    required super.target,
    required super.bricks,
    super.seconds = 30,
  });

  /// Builds a puzzle from an ASCII bitmap where '#' marks a target cell.
  /// Emits one 1×1 brick per '#' cell for backwards compatibility.
  factory LetterPuzzleModel.fromBitmap({
    required String lessonId,
    required String glyph,
    required String transliteration,
    required List<String> bitmap,
    int seconds = 30,
  }) {
    final rows = bitmap.length;
    final cols = bitmap.isEmpty ? 0 : bitmap.first.length;
    final target = <BlockPosition>{};
    final bricks = <PuzzleBrick>[];
    final rng = _SeededRandom(lessonId.hashCode);

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < bitmap[r].length; c++) {
        if (bitmap[r][c] == '#') {
          final pos = BlockPosition(r, c);
          target.add(pos);
          bricks.add(
            PuzzleBrick(
              id: 'r${r}c$c',
              cells: const [BlockPosition(0, 0)],
              colorIndex: 0,
              targetOrigin: pos,
              spawnOrigin: BlockPosition(
                rng.nextInt(rows),
                rng.nextInt(cols),
              ),
            ),
          );
        }
      }
    }

    return LetterPuzzleModel(
      lessonId: lessonId,
      glyph: glyph,
      transliteration: transliteration,
      rows: rows,
      cols: cols,
      target: target,
      bricks: bricks,
      seconds: seconds,
    );
  }

  /// Explicit brick layout for hand-designed letters.
  factory LetterPuzzleModel.fromBricks({
    required String lessonId,
    required String glyph,
    required String transliteration,
    required int rows,
    required int cols,
    required List<PuzzleBrick> bricks,
    int seconds = 30,
  }) {
    final target = <BlockPosition>{};
    for (final brick in bricks) {
      for (final cell in brick.cells) {
        target.add(BlockPosition(
          brick.targetOrigin.row + cell.row,
          brick.targetOrigin.col + cell.col,
        ));
      }
    }

    return LetterPuzzleModel(
      lessonId: lessonId,
      glyph: glyph,
      transliteration: transliteration,
      rows: rows,
      cols: cols,
      target: target,
      bricks: bricks,
      seconds: seconds,
    );
  }
}

/// Seeded random for deterministic spawn positions.
class _SeededRandom {
  _SeededRandom(this.seed);
  int seed;

  int nextInt(int max) {
    seed = (seed * 1103515245 + 12345) & 0x7fffffff;
    return seed % max;
  }
}
