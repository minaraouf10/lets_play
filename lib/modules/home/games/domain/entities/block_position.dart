import 'package:equatable/equatable.dart';

/// A single cell coordinate on the building grid.
class BlockPosition extends Equatable {
  const BlockPosition(this.row, this.col);

  final int row;
  final int col;

  @override
  List<Object?> get props => [row, col];

  @override
  String toString() => '($row,$col)';
}
