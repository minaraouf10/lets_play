import 'package:equatable/equatable.dart';

import 'block_position.dart';

/// One draggable LEGO brick. [cells] are offsets relative to the brick's own
/// origin, so the same shape can be reused at any [targetOrigin].
class PuzzleBrick extends Equatable {
  const PuzzleBrick({
    required this.id,
    required this.cells,
    required this.colorIndex,
    required this.targetOrigin,
    required this.spawnOrigin,
  });

  final String id;
  final List<BlockPosition> cells;

  /// Index into `kPuzzleBrickColors` (presentation). Keeps domain UI-agnostic.
  final int colorIndex;

  /// Where the brick belongs when solved.
  final BlockPosition targetOrigin;

  /// Where it starts, scattered, before the player moves it.
  final BlockPosition spawnOrigin;

  int get width => cells.isEmpty
      ? 0
      : cells.map((c) => c.col).reduce((a, b) => a > b ? a : b) + 1;
  int get height => cells.isEmpty
      ? 0
      : cells.map((c) => c.row).reduce((a, b) => a > b ? a : b) + 1;

  /// Identifies the brick's shape. Two bricks with the same [shapeKey] are
  /// interchangeable, so either one may fill the other's slot.
  String get shapeKey {
    final sorted = [...cells]..sort((a, b) {
        final byRow = a.row.compareTo(b.row);
        return byRow != 0 ? byRow : a.col.compareTo(b.col);
      });
    return sorted.map((c) => '${c.row}:${c.col}').join(',');
  }

  @override
  List<Object?> get props =>
      [id, cells, colorIndex, targetOrigin, spawnOrigin];
}
