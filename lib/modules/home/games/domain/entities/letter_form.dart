import 'package:equatable/equatable.dart';

import 'puzzle_brick.dart';

/// Where a letter sits inside a word. Arabic letters change shape by position.
enum LetterFormType { initial, isolated, medial, final_ }

/// One positional form of a letter, drawn from the same 1x1 / 1x2 brick set
/// as the puzzles so the artwork always matches the game pieces.
class LetterForm extends Equatable {
  const LetterForm({
    required this.type,
    required this.label,
    required this.rows,
    required this.cols,
    required this.bricks,
  });

  final LetterFormType type;
  final String label;
  final int rows;
  final int cols;

  /// Bricks positioned by their `targetOrigin`; rendered as a static picture.
  final List<PuzzleBrick> bricks;

  @override
  List<Object?> get props => [type, label, rows, cols, bricks];
}
