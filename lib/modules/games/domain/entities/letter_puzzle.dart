import 'package:equatable/equatable.dart';

import 'block_position.dart';
import 'puzzle_brick.dart';

/// A "build the letter" puzzle: draggable bricks that snap into their target
/// positions to assemble [glyph].
class LetterPuzzle extends Equatable {
  const LetterPuzzle({
    required this.lessonId,
    required this.glyph,
    required this.transliteration,
    required this.rows,
    required this.cols,
    required this.target,
    required this.bricks,
    this.seconds = 30,
  });

  final String lessonId;
  final String glyph;
  final String transliteration;
  final int rows;
  final int cols;

  /// The cells that together form the letter shape (union of all bricks' cells
  /// at their targetOrigin). Used for progress calculation.
  final Set<BlockPosition> target;

  /// The draggable bricks that make up this puzzle.
  final List<PuzzleBrick> bricks;

  /// Countdown allowance in seconds.
  final int seconds;

  @override
  List<Object?> get props => [
        lessonId,
        glyph,
        transliteration,
        rows,
        cols,
        target,
        bricks,
        seconds,
      ];
}

