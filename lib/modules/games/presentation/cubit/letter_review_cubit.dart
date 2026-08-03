import '../../domain/usecases/get_letter_puzzle_usecase.dart';
import '../../../../core/utils/app_imports.dart';

part 'letter_review_state.dart';

/// Drives the post-game "letter review" flow shown after [GreatJobPage]:
/// the plain glyph, then the assembled bricks, then the letter forms card.
@injectable
class LetterReviewCubit extends Cubit<LetterReviewState> {
  LetterReviewCubit(this._getPuzzle) : super(const LetterReviewState());

  final GetLetterPuzzleUseCase _getPuzzle;

  Future<void> load(String lessonId) async {
    emit(const LetterReviewState(status: LetterReviewStatus.loading));
    final result = await _getPuzzle(lessonId);
    result.fold(
      (failure) => emit(LetterReviewState(
        status: LetterReviewStatus.error,
        errorMessage: failure.message,
      )),
      (puzzle) => emit(LetterReviewState(
        status: LetterReviewStatus.ready,
        puzzle: puzzle,
      )),
    );
  }

  void continuePressed() {
    final next = LetterReviewStep.values[
        (state.step.index + 1).clamp(0, LetterReviewStep.values.length - 1)];
    emit(state.copyWith(step: next));
  }
}
