import '../../../../../core/utils/app_imports.dart';
import '../../data/datasources/word_lessons_data.dart';
import '../../domain/entities/word_lesson.dart';
import '../../domain/entities/word_option.dart';

part 'word_lesson_state.dart';

/// Drives the 4-step word lesson: hear the word and "repeat" it, pick it by
/// sound, pick it by text, then pick it by picture.
@injectable
class WordLessonCubit extends Cubit<WordLessonState> {
  WordLessonCubit(this._audio) : super(const WordLessonState());

  final LetterAudioService _audio;

  static const Duration recordingDuration =
      Duration(seconds: AppDimensions.wordRecordingSeconds);

  Future<void> load(String lessonId) async {
    emit(const WordLessonState(status: WordLessonStatus.loading));
    final lesson = wordLessonFor(lessonId);
    if (lesson == null) {
      emit(const WordLessonState(
        status: WordLessonStatus.error,
        errorMessage: 'No word lessons defined yet',
      ));
      return;
    }
    emit(WordLessonState(status: WordLessonStatus.repeat, lesson: lesson));
  }

  Future<void> playTargetWord() async {
    final word = state.lesson?.targetWord;
    if (word == null) return;
    await _say(word, markHeard: true);
  }

  Future<void> playTargetSlowly() async {
    final word = state.lesson?.targetWord;
    if (word == null) return;
    await _say(word, slowly: true, markHeard: true);
  }

  Future<void> playOption(WordOption option) => _say(option.word);

  Future<void> playImagePrompt() async {
    final word = state.lesson?.imagePromptWord;
    if (word == null) return;
    await _say(word);
  }

  Future<void> _say(String text, {bool slowly = false, bool markHeard = false}) async {
    await (slowly ? _audio.speakSlowly(text) : _audio.speak(text));
    if (isClosed) return;
    if (markHeard && !state.hasHeardTarget) {
      emit(state.copyWith(hasHeardTarget: true));
    }
    _reportAudioAvailability();
  }

  /// Placeholder mic: no speech recognition, just a timed "recording" state.
  Future<void> startRecording() async {
    if (state.status != WordLessonStatus.repeat || state.isRecording || state.hasRecorded) {
      return;
    }
    emit(state.copyWith(isRecording: true));
    await Future.delayed(recordingDuration);
    if (isClosed) return;
    emit(state.copyWith(isRecording: false, hasRecorded: true));
  }

  void chooseAudioOption(WordOption option) => _choose(
        status: WordLessonStatus.chooseAudio,
        correctId: state.lesson?.correctAudioOptionId,
        optionId: option.id,
        apply: (id) => state.copyWith(selectedAudioOptionId: id),
      );

  void chooseTextOption(WordOption option) => _choose(
        status: WordLessonStatus.chooseText,
        correctId: state.lesson?.correctTextOptionId,
        optionId: option.id,
        apply: (id) => state.copyWith(selectedTextOptionId: id),
      );

  void chooseImageOption(WordOption option) => _choose(
        status: WordLessonStatus.chooseImage,
        correctId: state.lesson?.correctImageOptionId,
        optionId: option.id,
        apply: (id) => state.copyWith(selectedImageOptionId: id),
      );

  void _choose({
    required WordLessonStatus status,
    required String? correctId,
    required String optionId,
    required WordLessonState Function(String id) apply,
  }) {
    if (state.status != status) return;
    final next = apply(optionId);
    if (optionId != correctId) {
      emit(next.copyWith(
        hearts: (state.hearts - 1).clamp(0, state.hearts),
        wasWrong: true,
      ));
      return;
    }
    emit(next.copyWith(wasWrong: false));
  }

  /// Advances to the next step; no-ops unless the current step is satisfied.
  void continuePressed() {
    if (!state.canContinue) return;
    final next = switch (state.status) {
      WordLessonStatus.repeat => WordLessonStatus.chooseAudio,
      WordLessonStatus.chooseAudio => WordLessonStatus.chooseText,
      WordLessonStatus.chooseText => WordLessonStatus.chooseImage,
      WordLessonStatus.chooseImage => WordLessonStatus.completed,
      _ => state.status,
    };
    emit(state.copyWith(status: next, wasWrong: false));
  }

  /// Surfaces a missing Arabic voice so the speaker buttons never fail silently.
  void _reportAudioAvailability() {
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
