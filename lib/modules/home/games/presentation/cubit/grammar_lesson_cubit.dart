import '../../data/datasources/grammar_data.dart';
import '../../domain/entities/grammar_lesson.dart';
import '../../../../../core/utils/app_imports.dart';

part 'grammar_lesson_state.dart';

/// Drives the Level 4 grammar screens that open a word lesson: the word-type
/// and noun-type reference cards, two "pick the noun" questions, and a
/// picture match.
///
/// A wrong pick costs a heart and is not accepted, so the player always
/// leaves a question having got it right — the rule every quiz here follows.
@injectable
class GrammarLessonCubit extends Cubit<GrammarLessonState> {
  GrammarLessonCubit(this._audio) : super(const GrammarLessonState());

  final LetterAudioService _audio;

  void load(String lessonId) {
    emit(const GrammarLessonState(status: GrammarStatus.loading));
    final lesson = grammarLessonFor(lessonId);
    if (lesson == null) {
      emit(const GrammarLessonState(
        status: GrammarStatus.error,
        errorMessage: 'No grammar lesson for this id',
      ));
      return;
    }
    emit(GrammarLessonState(
      status: GrammarStatus.playing,
      lesson: lesson,
      lessonId: lessonId,
    ));
  }

  /// Picks a tile on whichever question step is showing.
  void choose(String optionId) {
    if (state.status != GrammarStatus.playing) return;

    final correctId = switch (state.step) {
      GrammarChoiceStepData(:final choice) => choice.correctId,
      GrammarPictureStepData(:final question) => question.correctId,
      GrammarFillBlankStepData(:final correctId) => correctId,
      GrammarCategoryStepData(:final correctId) => correctId,
      // The reference and statement cards have no tiles to pick.
      _ => null,
    };
    if (correctId == null) return;

    if (optionId != correctId) {
      _loseHeart();
      emit(state.copyWith(selectedId: optionId));
      return;
    }
    emit(state.copyWith(selectedId: optionId));
  }

  /// Answers a True/False statement step.
  void answerStatement({required bool answer}) {
    if (state.status != GrammarStatus.playing) return;
    final current = state.step;
    if (current is! GrammarStatementStepData) return;

    if (answer != current.isTrue) {
      _loseHeart();
      emit(state.copyWith(statementAnswer: answer));
      return;
    }
    emit(state.copyWith(statementAnswer: answer));
  }

  void _loseHeart() {
    emit(state.copyWith(
      hearts: (state.hearts - 1).clamp(0, state.hearts),
      mistakes: state.mistakes + 1,
    ));
  }

  /// Speaks any Arabic term — the equation rows and the picture prompt all
  /// route through here.
  Future<void> speak(String text) async {
    await _audio.speak(text);
    if (isClosed) return;
    final unavailable = !_audio.isArabicAvailable;
    if (unavailable == state.audioUnavailable) return;
    emit(state.copyWith(audioUnavailable: unavailable));
  }

  /// Advances to the next screen, or completes the grammar section after the
  /// last one so the word steps can take over.
  void continuePressed() {
    if (!state.isStepAnswered) return;

    if (state.stepIndex >= state.stepCount - 1) {
      emit(state.copyWith(status: GrammarStatus.completed));
      return;
    }
    emit(state.copyWith(
      stepIndex: state.stepIndex + 1,
      clearAnswer: true,
    ));
  }

  @override
  Future<void> close() {
    _audio.stop();
    return super.close();
  }
}
