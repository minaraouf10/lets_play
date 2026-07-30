import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/block_position.dart';
import '../../domain/entities/game_result.dart';
import '../../domain/entities/letter_puzzle.dart';
import '../../domain/usecases/get_letter_puzzle_usecase.dart';
import '../../domain/usecases/save_game_result_usecase.dart';

part 'letter_game_state.dart';

@injectable
class LetterGameCubit extends Cubit<LetterGameState> {
  LetterGameCubit(this._getPuzzle, this._saveResult)
      : super(const LetterGameState());

  final GetLetterPuzzleUseCase _getPuzzle;
  final SaveGameResultUseCase _saveResult;

  Future<void> load(String lessonId) async {
    emit(const LetterGameState(status: GameStatus.loading));
    final result = await _getPuzzle(lessonId);
    result.fold(
      (failure) => emit(LetterGameState(
        status: GameStatus.error,
        errorMessage: failure.message,
      )),
      (puzzle) => emit(LetterGameState(
        status: GameStatus.playing,
        puzzle: puzzle,
      )),
    );
  }

  void selectColor(int index) => emit(state.copyWith(selectedColor: index));

  /// Tapping a cell: fills a correct target cell, toggles it off if already
  /// filled, or records a mistake when tapping outside the letter shape.
  void tapCell(BlockPosition pos) {
    final puzzle = state.puzzle;
    if (puzzle == null || state.status != GameStatus.playing) return;

    final isTarget = puzzle.target.contains(pos);
    final filled = Set<BlockPosition>.from(state.filled);

    if (!isTarget) {
      emit(state.copyWith(mistakes: state.mistakes + 1));
      return;
    }

    if (filled.contains(pos)) {
      filled.remove(pos); // undo
    } else {
      filled.add(pos);
    }

    final completed = filled.length == puzzle.target.length &&
        filled.containsAll(puzzle.target);

    if (completed) {
      final stars = _starsFor(state.mistakes);
      emit(state.copyWith(
        filled: filled,
        status: GameStatus.completed,
        stars: stars,
      ));
      _saveResult(GameResult(
        lessonId: puzzle.lessonId,
        stars: stars,
        mistakes: state.mistakes,
      ));
    } else {
      emit(state.copyWith(filled: filled));
    }
  }

  void reset() {
    final puzzle = state.puzzle;
    if (puzzle == null) return;
    emit(LetterGameState(status: GameStatus.playing, puzzle: puzzle));
  }

  int _starsFor(int mistakes) {
    if (mistakes == 0) return 3;
    if (mistakes <= 2) return 2;
    return 1;
  }
}
