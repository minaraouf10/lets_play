part of 'letter_game_cubit.dart';

enum GameStatus { loading, playing, completed, error }

class LetterGameState extends Equatable {
  const LetterGameState({
    this.status = GameStatus.loading,
    this.puzzle,
    this.filled = const {},
    this.selectedColor = 0,
    this.mistakes = 0,
    this.stars = 0,
    this.errorMessage,
  });

  final GameStatus status;
  final LetterPuzzle? puzzle;
  final Set<BlockPosition> filled;
  final int selectedColor;
  final int mistakes;
  final int stars;
  final String? errorMessage;

  /// Progress toward completion, 0..1.
  double get progress {
    final total = puzzle?.target.length ?? 0;
    if (total == 0) return 0;
    final correct = filled.intersection(puzzle!.target).length;
    return correct / total;
  }

  LetterGameState copyWith({
    GameStatus? status,
    LetterPuzzle? puzzle,
    Set<BlockPosition>? filled,
    int? selectedColor,
    int? mistakes,
    int? stars,
    String? errorMessage,
  }) {
    return LetterGameState(
      status: status ?? this.status,
      puzzle: puzzle ?? this.puzzle,
      filled: filled ?? this.filled,
      selectedColor: selectedColor ?? this.selectedColor,
      mistakes: mistakes ?? this.mistakes,
      stars: stars ?? this.stars,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, puzzle, filled, selectedColor, mistakes, stars, errorMessage];
}
