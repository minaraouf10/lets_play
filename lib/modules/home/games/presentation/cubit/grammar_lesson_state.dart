part of 'grammar_lesson_cubit.dart';

enum GrammarStatus { loading, playing, completed, error }

class GrammarLessonState extends Equatable {
  const GrammarLessonState({
    this.status = GrammarStatus.loading,
    this.stepIndex = 0,
    this.lesson,
    this.lessonId = '',
    this.selectedId,
    this.statementAnswer,
    this.hearts = 6,
    this.mistakes = 0,
    this.audioUnavailable = false,
    this.errorMessage,
  });

  final GrammarStatus status;

  /// Position in [GrammarLesson.steps].
  final int stepIndex;

  final GrammarLesson? lesson;
  final String lessonId;

  /// The tile picked on the current step, if any.
  final String? selectedId;

  /// The True/False answer given on a statement step, if any.
  final bool? statementAnswer;

  final int hearts;

  /// Wrong answers so far, carried into the lesson's result.
  final int mistakes;
  final bool audioUnavailable;
  final String? errorMessage;

  /// The screen currently showing.
  GrammarStepData? get step {
    final steps = lesson?.steps;
    if (steps == null || stepIndex >= steps.length) return null;
    return steps[stepIndex];
  }

  int get stepCount => lesson?.steps.length ?? 0;

  /// Reference cards ask nothing, so CONTINUE is live on them immediately;
  /// question steps need the right answer first.
  bool get isStepAnswered {
    final current = step;
    return switch (current) {
      null => false,
      GrammarEquationCard() || GrammarTermsCard() => true,
      GrammarChoiceStepData(:final choice) => selectedId == choice.correctId,
      GrammarPictureStepData(:final question) =>
        selectedId == question.correctId,
      GrammarFillBlankStepData(:final correctId) => selectedId == correctId,
      GrammarCategoryStepData(:final correctId) => selectedId == correctId,
      GrammarStatementStepData(:final isTrue) => statementAnswer == isTrue,
    };
  }

  double get progress => switch (status) {
        GrammarStatus.loading || GrammarStatus.error => 0,
        GrammarStatus.completed => 1,
        GrammarStatus.playing => stepCount == 0
            ? 0
            : (stepIndex + (isStepAnswered ? 1 : 0)) / stepCount,
      };

  GrammarLessonState copyWith({
    GrammarStatus? status,
    int? stepIndex,
    GrammarLesson? lesson,
    String? lessonId,
    String? selectedId,
    bool? statementAnswer,
    bool clearAnswer = false,
    int? hearts,
    int? mistakes,
    bool? audioUnavailable,
    String? errorMessage,
  }) {
    return GrammarLessonState(
      status: status ?? this.status,
      stepIndex: stepIndex ?? this.stepIndex,
      lesson: lesson ?? this.lesson,
      lessonId: lessonId ?? this.lessonId,
      selectedId: clearAnswer ? null : selectedId ?? this.selectedId,
      statementAnswer:
          clearAnswer ? null : statementAnswer ?? this.statementAnswer,
      hearts: hearts ?? this.hearts,
      mistakes: mistakes ?? this.mistakes,
      audioUnavailable: audioUnavailable ?? this.audioUnavailable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        stepIndex,
        lesson,
        lessonId,
        selectedId,
        statementAnswer,
        hearts,
        mistakes,
        audioUnavailable,
        errorMessage,
      ];
}
