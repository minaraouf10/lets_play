import '../../../learning/domain/usecases/get_levels_usecase.dart';
import '../../data/datasources/letter_names_data.dart';
import '../../../../../core/utils/app_imports.dart';

part 'letter_quiz_state.dart';

/// Drives the two-question quiz shown after the letter has been traced:
/// "listen and choose" then a true/false statement about another letter.
@injectable
class LetterQuizCubit extends Cubit<LetterQuizState> {
  LetterQuizCubit(this._getLevels, this._audio) : super(const LetterQuizState());

  final GetLevelsUseCase _getLevels;
  final LetterAudioService _audio;

  Future<void> load(String lessonId) async {
    emit(const LetterQuizState(status: QuizStatus.loading));
    final result = await _getLevels(const NoParams());
    result.fold(
      (failure) => emit(LetterQuizState(
        status: QuizStatus.error,
        errorMessage: failure.message,
      )),
      (levels) {
        final lessons = levels.expand((l) => l.lessons).toList();
        final target = lessons.firstWhere(
          (l) => l.id == lessonId,
          orElse: () => lessons.first,
        );
        final others = lessons.where((l) => l.id != target.id).toList();
        if (others.isEmpty) {
          emit(const LetterQuizState(
            status: QuizStatus.error,
            errorMessage: 'Not enough letters for a quiz',
          ));
          return;
        }

        // Deterministic per lesson so the options never reshuffle on rebuild.
        final seed = lessonId.hashCode.abs();
        final distractor = others[seed % others.length];
        final correctFirst = seed.isEven;

        emit(LetterQuizState(
          status: QuizStatus.choosing,
          target: target,
          options: correctFirst
              ? [target, distractor]
              : [distractor, target],
          // The true/false claim reuses the distractor, so it is false
          // whenever the two letters differ — which they always do here.
          statementLetter: distractor,
          statementIsTrue: false,
        ));
      },
    );
  }

  Future<void> playLetter() async {
    final text = _spokenTarget;
    if (text == null) return;
    await _audio.speak(text);
    _reportAudioAvailability();
  }

  Future<void> playLetterSlowly() async {
    final text = _spokenTarget;
    if (text == null) return;
    await _audio.speakSlowly(text);
    _reportAudioAvailability();
  }

  /// Surfaces a missing Arabic voice so the button never fails silently.
  void _reportAudioAvailability() {
    if (isClosed) return;
    final unavailable = !_audio.isArabicAvailable;
    if (unavailable == state.audioUnavailable) return;
    emit(state.copyWith(audioUnavailable: unavailable));
  }

  /// The letter's spoken name — engines usually skip a bare letter character.
  String? get _spokenTarget {
    final target = state.target;
    if (target == null) return null;
    return spokenLetterFor(target.id, target.glyph);
  }

  /// Answers question 1. A wrong pick costs a heart and is not accepted.
  void chooseOption(LessonEntity option) {
    if (state.status != QuizStatus.choosing) return;
    if (option.id != state.target?.id) {
      emit(state.copyWith(
        hearts: (state.hearts - 1).clamp(0, state.hearts),
        selectedOptionId: option.id,
        wasWrong: true,
      ));
      return;
    }
    emit(state.copyWith(selectedOptionId: option.id, wasWrong: false));
  }

  /// Moves from question 1 to question 2 once the right option is picked.
  void confirmChoice() {
    if (state.selectedOptionId != state.target?.id) return;
    emit(state.copyWith(
      status: QuizStatus.judging,
      selectedOptionId: null,
      wasWrong: false,
    ));
  }

  /// Answers question 2.
  void answerStatement({required bool answer}) {
    if (state.status != QuizStatus.judging) return;
    if (answer != state.statementIsTrue) {
      emit(state.copyWith(
        hearts: (state.hearts - 1).clamp(0, state.hearts),
        statementAnswer: answer,
        wasWrong: true,
      ));
      return;
    }
    emit(state.copyWith(statementAnswer: answer, wasWrong: false));
  }

  void finish() {
    if (state.statementAnswer != state.statementIsTrue) return;
    emit(state.copyWith(status: QuizStatus.completed));
  }

  @override
  Future<void> close() {
    _audio.stop();
    return super.close();
  }
}
