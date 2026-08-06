part of 'number_quiz_cubit.dart';

enum NumberQuizStatus { loading, playing, completed, error }

/// The six questions, in the order they are asked.
enum NumberQuizStep {
  /// "واحد Means 'One'" — true or false.
  statement,

  /// Hear the word, pick the matching digit from a 3x3 grid.
  listen,

  /// Count the bricks on screen and pick that digit.
  count,

  /// Trace the digit along a dotted baseline.
  write,

  /// Hear it, then say it into the mic.
  pronounce,

  /// Pick the digit that matches the illustration.
  pick,
}

class NumberQuizState extends Equatable {
  const NumberQuizState({
    this.status = NumberQuizStatus.loading,
    this.step = NumberQuizStep.statement,
    this.lesson,
    this.lessonId = '',
    this.puzzle,
    this.statementAnswer,
    this.selectedGlyph,
    this.listenOptions = const [],
    this.countOptions = const [],
    this.pickOptions = const [],
    this.legoCount = 1,
    this.filledCells = const {},
    this.hasWritten = false,
    this.isRecording = false,
    this.hasRecorded = false,
    this.hearts = 6,
    this.mistakes = 0,
    this.audioUnavailable = false,
    this.errorMessage,
  });

  final NumberQuizStatus status;
  final NumberQuizStep step;
  final NumberLesson? lesson;
  final String lessonId;

  /// Drives the "write the number" step's dotted outline.
  final LetterPuzzle? puzzle;

  /// Q1's answer, once given. The claim is always true, so a `false` here is
  /// simply wrong.
  final bool? statementAnswer;

  /// The digit picked on whichever choice step is showing.
  final String? selectedGlyph;

  /// Nine digits for Q2's grid, three for Q3 and Q6.
  final List<String> listenOptions;
  final List<String> countOptions;
  final List<String> pickOptions;

  /// How many bricks Q3 draws — equal to the number being taught.
  final int legoCount;

  /// Cells filled in so far on the "write the number" step.
  final Set<BlockPosition> filledCells;

  final bool hasWritten;
  final bool isRecording;
  final bool hasRecorded;
  final int hearts;

  /// Wrong answers so far, used for the accuracy on the results screen.
  final int mistakes;
  final bool audioUnavailable;
  final String? errorMessage;

  /// The digit every question is about, e.g. '١'.
  String get glyph => lesson?.glyph ?? '';

  /// Whether the current step has been answered correctly, which is what
  /// enables CONTINUE.
  bool get isStepAnswered => switch (step) {
        NumberQuizStep.statement => statementAnswer == true,
        NumberQuizStep.listen ||
        NumberQuizStep.count ||
        NumberQuizStep.pick =>
          selectedGlyph == glyph,
        NumberQuizStep.write => hasWritten,
        NumberQuizStep.pronounce => hasRecorded,
      };

  double get progress => switch (status) {
        NumberQuizStatus.loading || NumberQuizStatus.error => 0,
        NumberQuizStatus.completed => 1,
        NumberQuizStatus.playing =>
          (step.index + (isStepAnswered ? 1 : 0)) / NumberQuizStep.values.length,
      };

  /// Share of questions answered right first try, 0..1.
  double get accuracy {
    const total = 6;
    final right = (total - mistakes).clamp(0, total);
    return right / total;
  }

  NumberQuizState copyWith({
    NumberQuizStatus? status,
    NumberQuizStep? step,
    NumberLesson? lesson,
    String? lessonId,
    LetterPuzzle? puzzle,
    bool? statementAnswer,
    String? selectedGlyph,
    bool clearSelection = false,
    List<String>? listenOptions,
    List<String>? countOptions,
    List<String>? pickOptions,
    int? legoCount,
    Set<BlockPosition>? filledCells,
    bool? hasWritten,
    bool? isRecording,
    bool? hasRecorded,
    int? hearts,
    int? mistakes,
    bool? audioUnavailable,
    String? errorMessage,
  }) {
    return NumberQuizState(
      status: status ?? this.status,
      step: step ?? this.step,
      lesson: lesson ?? this.lesson,
      lessonId: lessonId ?? this.lessonId,
      puzzle: puzzle ?? this.puzzle,
      statementAnswer: statementAnswer ?? this.statementAnswer,
      selectedGlyph: clearSelection ? null : selectedGlyph ?? this.selectedGlyph,
      listenOptions: listenOptions ?? this.listenOptions,
      countOptions: countOptions ?? this.countOptions,
      pickOptions: pickOptions ?? this.pickOptions,
      legoCount: legoCount ?? this.legoCount,
      filledCells: filledCells ?? this.filledCells,
      hasWritten: hasWritten ?? this.hasWritten,
      isRecording: isRecording ?? this.isRecording,
      hasRecorded: hasRecorded ?? this.hasRecorded,
      hearts: hearts ?? this.hearts,
      mistakes: mistakes ?? this.mistakes,
      audioUnavailable: audioUnavailable ?? this.audioUnavailable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        step,
        lesson,
        lessonId,
        puzzle,
        statementAnswer,
        selectedGlyph,
        listenOptions,
        countOptions,
        pickOptions,
        legoCount,
        filledCells,
        hasWritten,
        isRecording,
        hasRecorded,
        hearts,
        mistakes,
        audioUnavailable,
        errorMessage,
      ];
}
