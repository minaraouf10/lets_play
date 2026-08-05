import 'dart:async';

import '../../domain/usecases/get_letter_puzzle_usecase.dart';
import '../../domain/usecases/save_game_result_usecase.dart';
import '../../../../../core/utils/app_imports.dart';

part 'letter_trace_state.dart';

/// Drives the "trace the letter" mode: the letter is shown as empty outlined
/// cells and the player drags across them to fill each one with a brick.
@injectable
class LetterTraceCubit extends Cubit<LetterTraceState> {
  LetterTraceCubit(this._getPuzzle, this._saveResult)
      : super(const LetterTraceState());

  final GetLetterPuzzleUseCase _getPuzzle;
  final SaveGameResultUseCase _saveResult;
  Timer? _ticker;

  Future<void> load(String lessonId) async {
    emit(const LetterTraceState(status: TraceStatus.loading));
    final result = await _getPuzzle(lessonId);
    result.fold(
      (failure) => emit(LetterTraceState(
        status: TraceStatus.error,
        errorMessage: failure.message,
      )),
      (puzzle) {
        emit(LetterTraceState(
          status: TraceStatus.tracing,
          puzzle: puzzle,
          secondsLeft: puzzle.seconds,
        ));
        _startTicker();
      },
    );
  }

  /// Fills [cell] if it is part of the letter and not already filled.
  void touchCell(BlockPosition cell) {
    final puzzle = state.puzzle;
    if (puzzle == null || state.status != TraceStatus.tracing) return;
    if (!puzzle.target.contains(cell)) return;
    if (state.filledCells.contains(cell)) return;

    final filled = Set<BlockPosition>.from(state.filledCells)..add(cell);
    final isComplete = filled.length == puzzle.target.length;

    if (isComplete) {
      _ticker?.cancel();
      emit(state.copyWith(
        filledCells: filled,
        status: TraceStatus.completed,
        energy: state.energy + AppDimensions.gameEnergyPerBrick,
        stars: 3,
      ));
      _saveResult(GameResult(
        lessonId: puzzle.lessonId,
        stars: 3,
        mistakes: 0,
      ));
    } else {
      emit(state.copyWith(
        filledCells: filled,
        energy: state.energy + AppDimensions.gameEnergyPerBrick,
      ));
    }
  }

  void reset() {
    final puzzle = state.puzzle;
    if (puzzle == null) return;
    emit(state.copyWith(
      status: TraceStatus.tracing,
      filledCells: const {},
      energy: 0,
      stars: 0,
      secondsLeft: puzzle.seconds,
    ));
    _startTicker();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.status != TraceStatus.tracing) return;
      final next = state.secondsLeft - 1;
      if (next <= 0) {
        _ticker?.cancel();
        emit(state.copyWith(status: TraceStatus.failed, secondsLeft: 0));
      } else {
        emit(state.copyWith(secondsLeft: next));
      }
    });
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
