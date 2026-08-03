part of 'letter_quiz_cubit.dart';

enum QuizStatus { loading, choosing, judging, completed, error }

class LetterQuizState extends Equatable {
  const LetterQuizState({
    this.status = QuizStatus.loading,
    this.target,
    this.options = const [],
    this.selectedOptionId,
    this.statementLetter,
    this.statementIsTrue = false,
    this.statementAnswer,
    this.wasWrong = false,
    this.hearts = 6,
    this.audioUnavailable = false,
    this.errorMessage,
  });

  final QuizStatus status;

  /// The letter the lesson is about — the correct answer to question 1.
  final LessonEntity? target;

  /// The two cards shown in question 1, already shuffled.
  final List<LessonEntity> options;

  final String? selectedOptionId;

  /// The letter shown in question 2's card.
  final LessonEntity? statementLetter;

  /// Whether the claim "[statementLetter] means [target]" is true.
  final bool statementIsTrue;

  /// What the player answered in question 2, if anything.
  final bool? statementAnswer;

  /// Set when the most recent answer was wrong, so the UI can flag it.
  final bool wasWrong;

  final int hearts;

  /// Set once a play attempt found no Arabic voice on the device.
  final bool audioUnavailable;

  final String? errorMessage;

  /// Question 1 is answered correctly and CONTINUE can be enabled.
  bool get isChoiceCorrect =>
      selectedOptionId != null && selectedOptionId == target?.id;

  /// Question 2 is answered correctly and CONTINUE can be enabled.
  bool get isStatementCorrect =>
      statementAnswer != null && statementAnswer == statementIsTrue;

  double get progress => switch (status) {
        QuizStatus.loading || QuizStatus.error => 0,
        QuizStatus.choosing => isChoiceCorrect ? 0.5 : 0.25,
        QuizStatus.judging => isStatementCorrect ? 1 : 0.75,
        QuizStatus.completed => 1,
      };

  LetterQuizState copyWith({
    QuizStatus? status,
    LessonEntity? target,
    List<LessonEntity>? options,
    String? selectedOptionId,
    LessonEntity? statementLetter,
    bool? statementIsTrue,
    bool? statementAnswer,
    bool? wasWrong,
    int? hearts,
    bool? audioUnavailable,
    String? errorMessage,
  }) {
    return LetterQuizState(
      status: status ?? this.status,
      target: target ?? this.target,
      options: options ?? this.options,
      selectedOptionId: selectedOptionId,
      statementLetter: statementLetter ?? this.statementLetter,
      statementIsTrue: statementIsTrue ?? this.statementIsTrue,
      statementAnswer: statementAnswer ?? this.statementAnswer,
      wasWrong: wasWrong ?? this.wasWrong,
      hearts: hearts ?? this.hearts,
      audioUnavailable: audioUnavailable ?? this.audioUnavailable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        target,
        options,
        selectedOptionId,
        statementLetter,
        statementIsTrue,
        statementAnswer,
        wasWrong,
        hearts,
        audioUnavailable,
        errorMessage,
      ];
}
