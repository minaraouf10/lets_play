part of 'letter_trace_cubit.dart';

enum TraceStatus { loading, tracing, completed, failed, error }

class LetterTraceState extends Equatable {
  const LetterTraceState({
    this.status = TraceStatus.loading,
    this.puzzle,
    this.filledCells = const {},
    this.energy = 0,
    this.hearts = 6,
    this.secondsLeft = 0,
    this.stars = 0,
    this.errorMessage,
  });

  final TraceStatus status;
  final LetterPuzzle? puzzle;

  /// Cells the player has traced over so far.
  final Set<BlockPosition> filledCells;

  final int energy;
  final int hearts;
  final int secondsLeft;
  final int stars;
  final String? errorMessage;

  /// Progress 0..1 across the letter's cells.
  double get progress {
    final total = puzzle?.target.length ?? 0;
    if (total == 0) return 0;
    return filledCells.length / total;
  }

  LetterTraceState copyWith({
    TraceStatus? status,
    LetterPuzzle? puzzle,
    Set<BlockPosition>? filledCells,
    int? energy,
    int? hearts,
    int? secondsLeft,
    int? stars,
    String? errorMessage,
  }) {
    return LetterTraceState(
      status: status ?? this.status,
      puzzle: puzzle ?? this.puzzle,
      filledCells: filledCells ?? this.filledCells,
      energy: energy ?? this.energy,
      hearts: hearts ?? this.hearts,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      stars: stars ?? this.stars,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        puzzle,
        filledCells,
        energy,
        hearts,
        secondsLeft,
        stars,
        errorMessage,
      ];
}
