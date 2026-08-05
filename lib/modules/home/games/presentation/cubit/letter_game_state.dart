part of 'letter_game_cubit.dart';

enum GameStatus { loading, playing, completed, failed, error }

class LetterGameState extends Equatable {
  const LetterGameState({
    this.status = GameStatus.loading,
    this.puzzle,
    this.positions = const {},
    this.placedIds = const {},
    this.filledSlots = const {},
    this.draggingId,
    this.energy = 0,
    this.hearts = 6,
    this.secondsLeft = 0,
    this.stars = 0,
    this.errorMessage,
  });

  final GameStatus status;
  final LetterPuzzle? puzzle;

  /// brickId -> current top-left cell offset (in grid units, stored as double).
  final Map<String, Offset> positions;

  /// brickIds that are locked in place.
  final Set<String> placedIds;

  /// Slot origin -> brickId currently occupying it. A slot is identified by the
  /// `targetOrigin` of the brick that defines it, so identical shapes are
  /// interchangeable: any 1x1 fits any free 1x1 slot.
  final Map<BlockPosition, String> filledSlots;

  /// Currently dragging brick, if any.
  final String? draggingId;

  final int energy;
  final int hearts;
  final int secondsLeft;
  final int stars;
  final String? errorMessage;

  /// Progress 0..1, based on placed bricks.
  double get progress {
    final total = puzzle?.bricks.length ?? 0;
    if (total == 0) return 0;
    return placedIds.length / total;
  }

  LetterGameState copyWith({
    GameStatus? status,
    LetterPuzzle? puzzle,
    Map<String, Offset>? positions,
    Set<String>? placedIds,
    Map<BlockPosition, String>? filledSlots,
    String? draggingId,
    int? energy,
    int? hearts,
    int? secondsLeft,
    int? stars,
    String? errorMessage,
  }) {
    return LetterGameState(
      status: status ?? this.status,
      puzzle: puzzle ?? this.puzzle,
      positions: positions ?? this.positions,
      placedIds: placedIds ?? this.placedIds,
      filledSlots: filledSlots ?? this.filledSlots,
      draggingId: draggingId,
      energy: energy ?? this.energy,
      hearts: hearts ?? this.hearts,
      secondsLeft: secondsLeft ?? this.secondsLeft,
      stars: stars ?? this.stars,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        puzzle,
        positions,
        placedIds,
        filledSlots,
        draggingId,
        energy,
        hearts,
        secondsLeft,
        stars,
        errorMessage,
      ];
}
