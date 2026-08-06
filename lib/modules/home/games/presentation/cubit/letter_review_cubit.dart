import '../../domain/usecases/get_letter_puzzle_usecase.dart';
import '../../data/datasources/letter_names_data.dart';
import '../../data/datasources/number_data.dart';
import '../../../../../core/utils/app_imports.dart';

part 'letter_review_state.dart';

/// Drives the post-game "letter review" flow shown after [GreatJobPage]:
/// the plain glyph, then the assembled bricks, then the letter forms card.
///
/// Number lessons (Level 3) have no positional forms, so their third step is
/// the "listen and read" card instead — see [LetterReviewStep.sound].
@injectable
class LetterReviewCubit extends Cubit<LetterReviewState> {
  LetterReviewCubit(this._getPuzzle, this._audio)
      : super(const LetterReviewState());

  final GetLetterPuzzleUseCase _getPuzzle;
  final LetterAudioService _audio;

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
        isNumber: isNumberLesson(lessonId),
      )),
    );
  }

  void continuePressed() {
    final next = LetterReviewStep.values[
        (state.step.index + 1).clamp(0, LetterReviewStep.values.length - 1)];
    emit(state.copyWith(step: next));
  }

  /// Pronounces the lesson on the number "listen and read" step.
  Future<void> playSound() async {
    final puzzle = state.puzzle;
    if (puzzle == null) return;
    await _audio.speak(spokenLetterFor(puzzle.lessonId, puzzle.glyph));
    if (isClosed) return;
    final unavailable = !_audio.isArabicAvailable;
    if (unavailable == state.audioUnavailable) return;
    emit(state.copyWith(audioUnavailable: unavailable));
  }

  @override
  Future<void> close() {
    _audio.stop();
    return super.close();
  }
}
