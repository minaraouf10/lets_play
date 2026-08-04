part of 'word_lesson_cubit.dart';

enum WordLessonStatus {
  loading,
  repeat,
  chooseAudio,
  chooseText,
  chooseImage,
  completed,
  error,
}

class WordLessonState extends Equatable {
  const WordLessonState({
    this.status = WordLessonStatus.loading,
    this.lesson,
    this.hasHeardTarget = false,
    this.isRecording = false,
    this.hasRecorded = false,
    this.selectedAudioOptionId,
    this.selectedTextOptionId,
    this.selectedImageOptionId,
    this.wasWrong = false,
    this.hearts = 6,
    this.audioUnavailable = false,
    this.errorMessage,
  });

  final WordLessonStatus status;
  final WordLesson? lesson;

  /// Step 1: the target word's speaker was tapped at least once.
  final bool hasHeardTarget;

  /// Step 1: the placeholder "recording" animation is running.
  final bool isRecording;

  /// Step 1: the placeholder recording finished.
  final bool hasRecorded;

  final String? selectedAudioOptionId;
  final String? selectedTextOptionId;
  final String? selectedImageOptionId;

  /// Set when the most recent answer was wrong, so the UI can flag it.
  final bool wasWrong;

  final int hearts;

  /// Set once a play attempt found no Arabic voice on the device.
  final bool audioUnavailable;

  final String? errorMessage;

  bool get isAudioCorrect =>
      selectedAudioOptionId != null &&
      selectedAudioOptionId == lesson?.correctAudioOptionId;

  bool get isTextCorrect =>
      selectedTextOptionId != null &&
      selectedTextOptionId == lesson?.correctTextOptionId;

  bool get isImageCorrect =>
      selectedImageOptionId != null &&
      selectedImageOptionId == lesson?.correctImageOptionId;

  /// Whether CONTINUE is enabled for the current step.
  bool get canContinue => switch (status) {
        WordLessonStatus.repeat => hasRecorded,
        WordLessonStatus.chooseAudio => isAudioCorrect,
        WordLessonStatus.chooseText => isTextCorrect,
        WordLessonStatus.chooseImage => isImageCorrect,
        _ => false,
      };

  double get progress => switch (status) {
        WordLessonStatus.loading || WordLessonStatus.error => 0,
        WordLessonStatus.repeat => hasRecorded ? 0.25 : 0.125,
        WordLessonStatus.chooseAudio => isAudioCorrect ? 0.50 : 0.375,
        WordLessonStatus.chooseText => isTextCorrect ? 0.75 : 0.625,
        WordLessonStatus.chooseImage => isImageCorrect ? 1.0 : 0.875,
        WordLessonStatus.completed => 1,
      };

  WordLessonState copyWith({
    WordLessonStatus? status,
    WordLesson? lesson,
    bool? hasHeardTarget,
    bool? isRecording,
    bool? hasRecorded,
    String? selectedAudioOptionId,
    String? selectedTextOptionId,
    String? selectedImageOptionId,
    bool? wasWrong,
    int? hearts,
    bool? audioUnavailable,
    String? errorMessage,
  }) {
    return WordLessonState(
      status: status ?? this.status,
      lesson: lesson ?? this.lesson,
      hasHeardTarget: hasHeardTarget ?? this.hasHeardTarget,
      isRecording: isRecording ?? this.isRecording,
      hasRecorded: hasRecorded ?? this.hasRecorded,
      selectedAudioOptionId: selectedAudioOptionId ?? this.selectedAudioOptionId,
      selectedTextOptionId: selectedTextOptionId ?? this.selectedTextOptionId,
      selectedImageOptionId: selectedImageOptionId ?? this.selectedImageOptionId,
      wasWrong: wasWrong ?? this.wasWrong,
      hearts: hearts ?? this.hearts,
      audioUnavailable: audioUnavailable ?? this.audioUnavailable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        lesson,
        hasHeardTarget,
        isRecording,
        hasRecorded,
        selectedAudioOptionId,
        selectedTextOptionId,
        selectedImageOptionId,
        wasWrong,
        hearts,
        audioUnavailable,
        errorMessage,
      ];
}
