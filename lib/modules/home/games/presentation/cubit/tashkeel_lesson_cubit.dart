import '../../data/datasources/tashkeel_data.dart';
import '../../domain/entities/lesson_result.dart';
import '../../domain/entities/tashkeel_sample.dart';
import '../../domain/entities/tashkeel_word.dart';
import '../../../../../core/utils/app_imports.dart';

part 'tashkeel_lesson_state.dart';

/// Points awarded for finishing a tashkeel lesson.
const int kTashkeelLessonPoints = 4060;

/// Drives the tashkeel lesson shown after the brick puzzle for a Level 2
/// lesson: each carrier letter is reviewed, then a pronunciation quiz over
/// those same carriers, then listen-and-repeat, then place-the-mark.
@injectable
class TashkeelLessonCubit extends Cubit<TashkeelLessonState> {
  TashkeelLessonCubit(this._audio) : super(const TashkeelLessonState());

  final LetterAudioService _audio;

  void load(String lessonId) {
    final samples = tashkeelSamplesFor(lessonId);
    if (samples.isEmpty) {
      emit(const TashkeelLessonState(
        status: TashkeelStatus.error,
        errorMessage: 'No tashkeel data for this lesson',
      ));
      return;
    }
    emit(TashkeelLessonState(
      status: TashkeelStatus.ready,
      lessonId: lessonId,
      samples: samples,
      vowel: tashkeelVowelFor(lessonId),
      markName: tashkeelMarkNameFor(lessonId),
      word: tashkeelWordFor(lessonId),
      markSitsAbove: tashkeelSitsAbove(lessonId),
      startedAt: DateTime.now(),
    ));
  }

  /// Records an answer for the accuracy score. Only the first attempt at each
  /// question counts, so retries after a wrong pick do not skew it.
  TashkeelLessonState _scored({required bool correct}) => state.copyWith(
        totalAnswers: state.totalAnswers + 1,
        wrongAnswers: state.wrongAnswers + (correct ? 0 : 1),
      );

  Future<void> playCurrent() async {
    final sample = state.currentSample;
    if (sample == null) return;
    await _audio.speak(sample.spoken);
    _reportAudioAvailability();
  }

  Future<void> playCurrentSlowly() async {
    final sample = state.currentSample;
    if (sample == null) return;
    await _audio.speakSlowly(sample.spoken);
    _reportAudioAvailability();
  }

  void _reportAudioAvailability() {
    if (isClosed) return;
    final unavailable = !_audio.isArabicAvailable;
    if (unavailable == state.audioUnavailable) return;
    emit(state.copyWith(audioUnavailable: unavailable));
  }

  /// Advances the review step through every carrier letter, then moves on to
  /// the quiz.
  void continueReview() {
    if (state.step != TashkeelStep.review) return;
    final next = state.sampleIndex + 1;
    if (next < state.samples.length) {
      emit(state.copyWith(sampleIndex: next));
      return;
    }
    emit(state.copyWith(step: TashkeelStep.quiz, sampleIndex: 0));
  }

  /// Answers the pronunciation question. A wrong pick costs a heart and is
  /// not accepted, matching the letter quiz.
  void chooseSyllable(String syllable) {
    if (state.step != TashkeelStep.quiz) return;
    // Only the first attempt at this carrier counts toward accuracy.
    final isFirstAttempt = state.selectedSyllable == null;
    final correct = syllable == state.currentSample?.syllable;
    final scored = isFirstAttempt ? _scored(correct: correct) : state;

    if (!correct) {
      emit(scored.copyWith(
        hearts: (state.hearts - 1).clamp(0, state.hearts),
        selectedSyllable: syllable,
        wasWrong: true,
      ));
      return;
    }
    emit(scored.copyWith(selectedSyllable: syllable, wasWrong: false));
  }

  /// Advances the quiz through every carrier, then moves on to repeat.
  void continueQuiz() {
    if (!state.isQuizAnswerCorrect) return;
    final next = state.sampleIndex + 1;
    if (next < state.samples.length) {
      emit(state.copyWith(
        sampleIndex: next,
        clearSelection: true,
        wasWrong: false,
      ));
      return;
    }
    emit(state.copyWith(
      step: TashkeelStep.repeat,
      sampleIndex: 0,
      clearSelection: true,
    ));
  }

  /// Placeholder "recording" state — there is no speech recognition behind
  /// the mic, mirroring [WordLessonCubit].
  Future<void> record() async {
    if (state.isRecording || state.hasRecorded) return;
    emit(state.copyWith(isRecording: true));
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (isClosed) return;
    emit(state.copyWith(isRecording: false, hasRecorded: true));
  }

  void continueRepeat() {
    if (state.step != TashkeelStep.repeat) return;
    emit(state.copyWith(step: TashkeelStep.place));
  }

  /// Answers the "place the mark" question by picking one of the slots.
  void choosePlacement(TashkeelPlacement placement) {
    if (state.step != TashkeelStep.place) return;
    final isFirstAttempt = state.selectedPlacement == null;
    final correct = placement == TashkeelPlacement.above;
    final scored = isFirstAttempt ? _scored(correct: correct) : state;

    if (!correct) {
      emit(scored.copyWith(
        hearts: (state.hearts - 1).clamp(0, state.hearts),
        selectedPlacement: placement,
        wasWrong: true,
      ));
      return;
    }
    emit(scored.copyWith(selectedPlacement: placement, wasWrong: false));
  }

  /// Moves from placing the mark to the whole-word steps.
  void continuePlace() {
    if (!state.isPlacementCorrect) return;
    emit(state.copyWith(step: TashkeelStep.wordRepeat, clearSelection: true));
  }

  /// The word step's own placeholder "recording" state.
  Future<void> recordWord() async {
    if (state.isRecording || state.wordHasRecorded) return;
    emit(state.copyWith(isRecording: true));
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    if (isClosed) return;
    emit(state.copyWith(isRecording: false, wordHasRecorded: true));
  }

  Future<void> playWord() async {
    final word = state.word;
    if (word == null) return;
    await _audio.speak(word.word);
    _reportAudioAvailability();
  }

  Future<void> playWordSlowly() async {
    final word = state.word;
    if (word == null) return;
    await _audio.speakSlowly(word.word);
    _reportAudioAvailability();
  }

  void continueWordRepeat() {
    if (state.step != TashkeelStep.wordRepeat) return;
    emit(state.copyWith(step: TashkeelStep.wordBuild));
  }

  /// Drops a piece into the word's blank.
  void dropPiece(String piece) {
    if (state.step != TashkeelStep.wordBuild) return;
    final isFirstAttempt = state.droppedPiece == null;
    final correct = piece == state.word?.missingPiece;
    final scored = isFirstAttempt ? _scored(correct: correct) : state;

    if (!correct) {
      emit(scored.copyWith(
        hearts: (state.hearts - 1).clamp(0, state.hearts),
        droppedPiece: piece,
        wasWrong: true,
      ));
      return;
    }
    emit(scored.copyWith(droppedPiece: piece, wasWrong: false));
  }

  void continueWordBuild() {
    if (!state.isWordBuildCorrect) return;
    emit(state.copyWith(step: TashkeelStep.shapeMatch, clearSelection: true));
  }

  /// Drops the mark's name onto one of the two written shapes.
  void chooseShape({required bool isAbove}) {
    if (state.step != TashkeelStep.shapeMatch) return;
    final isFirstAttempt = state.selectedShapeIsAbove == null;
    final correct = isAbove == state.markSitsAbove;
    final scored = isFirstAttempt ? _scored(correct: correct) : state;

    if (!correct) {
      emit(scored.copyWith(
        hearts: (state.hearts - 1).clamp(0, state.hearts),
        selectedShapeIsAbove: isAbove,
        wasWrong: true,
      ));
      return;
    }
    emit(scored.copyWith(selectedShapeIsAbove: isAbove, wasWrong: false));
  }

  void finish() {
    if (!state.isShapeMatchCorrect) return;
    final startedAt = state.startedAt;
    emit(state.copyWith(
      status: TashkeelStatus.completed,
      elapsed:
          startedAt == null ? Duration.zero : DateTime.now().difference(startedAt),
    ));
  }

  @override
  Future<void> close() {
    _audio.stop();
    return super.close();
  }
}
