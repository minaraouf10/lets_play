import 'dart:async';

import '../../domain/usecases/get_letter_puzzle_usecase.dart';
import '../../domain/usecases/save_game_result_usecase.dart';
import '../../../../core/utils/app_imports.dart';

part 'letter_game_state.dart';

@injectable
class LetterGameCubit extends Cubit<LetterGameState> {
  LetterGameCubit(this._getPuzzle, this._saveResult)
      : super(const LetterGameState());

  final GetLetterPuzzleUseCase _getPuzzle;
  final SaveGameResultUseCase _saveResult;
  Timer? _ticker;

  Future<void> load(String lessonId) async {
    emit(const LetterGameState(status: GameStatus.loading));
    final result = await _getPuzzle(lessonId);
    result.fold(
      (failure) => emit(LetterGameState(
        status: GameStatus.error,
        errorMessage: failure.message,
      )),
      (puzzle) {
        final positions = <String, Offset>{};
        for (final brick in puzzle.bricks) {
          positions[brick.id] = Offset(
            brick.spawnOrigin.col.toDouble(),
            brick.spawnOrigin.row.toDouble(),
          );
        }
        emit(LetterGameState(
          status: GameStatus.playing,
          puzzle: puzzle,
          positions: positions,
          secondsLeft: puzzle.seconds,
          hearts: 6,
        ));
        _startTicker();
      },
    );
  }

  void startDrag(String brickId) {
    if (state.placedIds.contains(brickId)) return;
    emit(state.copyWith(draggingId: brickId));
  }

  void updateDrag(String brickId, Offset deltaInCells) {
    if (state.status != GameStatus.playing) return;
    final currentPos = state.positions[brickId] ?? Offset.zero;
    final newPos = currentPos + deltaInCells;
    emit(state.copyWith(
      positions: {...state.positions, brickId: newPos},
    ));
  }

  void endDrag(String brickId) {
    final puzzle = state.puzzle;
    if (puzzle == null || state.status != GameStatus.playing) return;

    final brick = puzzle.bricks.firstWhere((b) => b.id == brickId);
    final currentPos = state.positions[brickId] ?? Offset.zero;
    final cellPitch = AppDimensions.gameCellSize + AppDimensions.gameCellGap;
    final currentPx = currentPos * cellPitch;

    // A brick may fill ANY free slot of the same shape, not just its own.
    // This is what makes identical pieces interchangeable for the player.
    BlockPosition? bestSlot;
    var bestDistance = double.infinity;
    for (final candidate in puzzle.bricks) {
      if (candidate.shapeKey != brick.shapeKey) continue;
      final slot = candidate.targetOrigin;
      if (state.filledSlots.containsKey(slot)) continue;

      final slotPx = Offset(
            slot.col.toDouble(),
            slot.row.toDouble(),
          ) *
          cellPitch;
      final distance = (currentPx - slotPx).distance;
      if (distance < bestDistance) {
        bestDistance = distance;
        bestSlot = slot;
      }
    }

    if (bestSlot == null || bestDistance > AppDimensions.gameSnapTolerance) {
      emit(state.copyWith(draggingId: null));
      return;
    }

    final snappedPos = Offset(
      bestSlot.col.toDouble(),
      bestSlot.row.toDouble(),
    );
    final placed = Set<String>.from(state.placedIds)..add(brickId);
    final slots = Map<BlockPosition, String>.from(state.filledSlots)
      ..[bestSlot] = brickId;
    final newEnergy = state.energy + AppDimensions.gameEnergyPerBrick;
    final isComplete = placed.length == puzzle.bricks.length;

    if (isComplete) {
      _ticker?.cancel();
      final stars = _starsFor(0);
      emit(state.copyWith(
        positions: {...state.positions, brickId: snappedPos},
        placedIds: placed,
        filledSlots: slots,
        draggingId: null,
        energy: newEnergy,
        status: GameStatus.completed,
        stars: stars,
      ));
      _saveResult(GameResult(
        lessonId: puzzle.lessonId,
        stars: stars,
        mistakes: 0,
      ));
    } else {
      emit(state.copyWith(
        positions: {...state.positions, brickId: snappedPos},
        placedIds: placed,
        filledSlots: slots,
        draggingId: null,
        energy: newEnergy,
      ));
    }
  }

  void reset() {
    final puzzle = state.puzzle;
    if (puzzle == null) return;
    final positions = <String, Offset>{};
    for (final brick in puzzle.bricks) {
      positions[brick.id] = Offset(
        brick.spawnOrigin.col.toDouble(),
        brick.spawnOrigin.row.toDouble(),
      );
    }
    emit(state.copyWith(
      status: GameStatus.playing,
      positions: positions,
      placedIds: const {},
      filledSlots: const {},
      draggingId: null,
      energy: 0,
      secondsLeft: puzzle.seconds,
      stars: 0,
    ));
    _startTicker();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.status != GameStatus.playing) return;
      final newSeconds = state.secondsLeft - 1;
      if (newSeconds <= 0) {
        _ticker?.cancel();
        emit(state.copyWith(
          status: GameStatus.failed,
          stars: 0,
          secondsLeft: 0,
        ));
      } else {
        emit(state.copyWith(secondsLeft: newSeconds));
      }
    });
  }

  int _starsFor(int mistakes) {
    if (mistakes == 0) return 3;
    if (mistakes <= 2) return 2;
    return 1;
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
