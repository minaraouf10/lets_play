import '../../domain/entities/block_position.dart';
import '../../domain/entities/letter_puzzle.dart';

class LetterPuzzleModel extends LetterPuzzle {
  const LetterPuzzleModel({
    required super.lessonId,
    required super.glyph,
    required super.transliteration,
    required super.rows,
    required super.cols,
    required super.target,
  });

  /// Builds a puzzle from an ASCII bitmap where '#' marks a target cell.
  /// All rows must share the same width.
  factory LetterPuzzleModel.fromBitmap({
    required String lessonId,
    required String glyph,
    required String transliteration,
    required List<String> bitmap,
  }) {
    final rows = bitmap.length;
    final cols = bitmap.isEmpty ? 0 : bitmap.first.length;
    final target = <BlockPosition>{};
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < bitmap[r].length; c++) {
        if (bitmap[r][c] == '#') target.add(BlockPosition(r, c));
      }
    }
    return LetterPuzzleModel(
      lessonId: lessonId,
      glyph: glyph,
      transliteration: transliteration,
      rows: rows,
      cols: cols,
      target: target,
    );
  }
}
