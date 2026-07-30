import 'package:equatable/equatable.dart';

import 'block_position.dart';

/// A "build the letter" puzzle: a grid where a set of [target] cells forms
/// the shape of [glyph]. The child fills cells with bricks until the filled
/// set matches [target].
class LetterPuzzle extends Equatable {
  const LetterPuzzle({
    required this.lessonId,
    required this.glyph,
    required this.transliteration,
    required this.rows,
    required this.cols,
    required this.target,
  });

  final String lessonId;
  final String glyph;
  final String transliteration;
  final int rows;
  final int cols;

  /// The cells that together form the letter shape.
  final Set<BlockPosition> target;

  @override
  List<Object?> get props =>
      [lessonId, glyph, transliteration, rows, cols, target];
}
