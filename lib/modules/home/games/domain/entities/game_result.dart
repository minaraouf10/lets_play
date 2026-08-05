import 'package:equatable/equatable.dart';

/// Outcome of a completed puzzle.
class GameResult extends Equatable {
  const GameResult({
    required this.lessonId,
    required this.stars,
    required this.mistakes,
  });

  final String lessonId;
  final int stars; // 0..3
  final int mistakes;

  @override
  List<Object?> get props => [lessonId, stars, mistakes];
}
