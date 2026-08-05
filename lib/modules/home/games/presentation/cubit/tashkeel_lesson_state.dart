part of 'tashkeel_lesson_cubit.dart';

enum TashkeelStatus { loading, ready, completed, error }

/// The stages of a tashkeel lesson, in order: review each carrier, quiz its
/// pronunciation, place the mark, then learn a whole word using it —
/// hear it, rebuild it, and finally match the mark to its written shape.
enum TashkeelStep {
  review,
  quiz,
  repeat,
  place,
  wordRepeat,
  wordBuild,
  shapeMatch,
}

/// Where the mark can be placed relative to the baseline. Only [above] is
/// correct for a fatha.
enum TashkeelPlacement { above, belowLeft, belowRight }

class TashkeelLessonState extends Equatable {
  const TashkeelLessonState({
    this.status = TashkeelStatus.loading,
    this.step = TashkeelStep.review,
    this.lessonId = '',
    this.samples = const [],
    this.sampleIndex = 0,
    this.vowel = 'a',
    this.markName = 'Tashkeel',
    this.selectedSyllable,
    this.selectedPlacement,
    this.word,
    this.droppedPiece,
    this.selectedShapeIsAbove,
    this.markSitsAbove = true,
    this.isRecording = false,
    this.hasRecorded = false,
    this.wordHasRecorded = false,
    this.wasWrong = false,
    this.hearts = 6,
    this.wrongAnswers = 0,
    this.totalAnswers = 0,
    this.startedAt,
    this.elapsed = Duration.zero,
    this.audioUnavailable = false,
    this.errorMessage,
  });

  final TashkeelStatus status;
  final TashkeelStep step;
  final String lessonId;

  /// The carrier letters this lesson walks through.
  final List<TashkeelSample> samples;

  /// Which carrier is currently on screen, within the current [step].
  final int sampleIndex;

  /// The short vowel the mark adds, e.g. 'a' for a fatha.
  final String vowel;

  /// Display name of the mark, e.g. 'Fatha'.
  final String markName;

  final String? selectedSyllable;
  final TashkeelPlacement? selectedPlacement;

  /// The whole word taught in the last three steps.
  final TashkeelWord? word;

  /// The piece dragged into the blank on the word-build step.
  final String? droppedPiece;

  /// Which shape was picked on the shape-match step, if any.
  final bool? selectedShapeIsAbove;

  /// Whether this lesson's mark is written above the line.
  final bool markSitsAbove;

  final bool isRecording;
  final bool hasRecorded;

  /// The word step's own recording flag, kept apart from [hasRecorded] so the
  /// two repeat screens do not unlock each other.
  final bool wordHasRecorded;

  /// Set when the most recent answer was wrong, so the UI can flag it.
  final bool wasWrong;

  final int hearts;

  /// Answers got wrong on the first try, used for the accuracy score.
  final int wrongAnswers;

  /// Questions answered so far, used for the accuracy score.
  final int totalAnswers;

  /// When the lesson began, used for the elapsed time on the result screen.
  final DateTime? startedAt;

  /// How long the lesson took, frozen when it completes.
  final Duration elapsed;

  final bool audioUnavailable;
  final String? errorMessage;

  TashkeelSample? get currentSample =>
      sampleIndex < samples.length ? samples[sampleIndex] : null;

  bool get isQuizAnswerCorrect =>
      selectedSyllable != null && selectedSyllable == currentSample?.syllable;

  bool get isPlacementCorrect => selectedPlacement == TashkeelPlacement.above;

  /// The right piece has been dropped into the word's blank.
  bool get isWordBuildCorrect => droppedPiece == word?.missingPiece;

  /// The shape matching where this mark actually sits has been picked.
  bool get isShapeMatchCorrect => selectedShapeIsAbove == markSitsAbove;

  /// The pieces offered on the word-build step, ordered deterministically so
  /// they never reshuffle on rebuild.
  List<String> get wordPieceOptions {
    final w = word;
    if (w == null) return const [];
    final options = [w.missingPiece, ...w.distractors];
    // Rotate so the answer is not always first.
    final shift = w.missingIndex % options.length;
    return [...options.sublist(shift), ...options.sublist(0, shift)];
  }

  /// What the player earned, for the congratulations screen.
  LessonResult get result => LessonResult(
        points: kTashkeelLessonPoints,
        accuracy: totalAnswers == 0
            ? 1
            : (totalAnswers - wrongAnswers) / totalAnswers,
        elapsed: elapsed,
      );

  /// The three pronunciation options, ordered deterministically per carrier so
  /// they never reshuffle on rebuild. Built from every carrier's syllable so
  /// the distractors are always plausible for this mark's lesson.
  List<String> get syllableOptions {
    final sample = currentSample;
    if (sample == null) return const [];

    final all = <String>{sample.syllable};
    // Same carrier with the other two short vowels, e.g. Ka -> Ki, Ko.
    final stem = sample.syllable.substring(0, sample.syllable.length - 1);
    for (final v in ['a', 'i', 'o']) {
      all.add('$stem$v');
    }

    final options = all.take(3).toList();
    // Rotate by carrier index so the answer is not always in the same slot.
    final shift = sampleIndex % options.length;
    return [...options.sublist(shift), ...options.sublist(0, shift)];
  }

  /// Overall progress across every step, for the top bar.
  double get progress {
    if (samples.isEmpty) return 0;
    if (status == TashkeelStatus.completed) return 1;
    final stepCount = TashkeelStep.values.length;
    final withinStep = switch (step) {
      TashkeelStep.review || TashkeelStep.quiz =>
        (sampleIndex + 1) / samples.length,
      TashkeelStep.repeat => hasRecorded ? 1.0 : 0.5,
      TashkeelStep.place => isPlacementCorrect ? 1.0 : 0.5,
      TashkeelStep.wordRepeat => wordHasRecorded ? 1.0 : 0.5,
      TashkeelStep.wordBuild => isWordBuildCorrect ? 1.0 : 0.5,
      TashkeelStep.shapeMatch => isShapeMatchCorrect ? 1.0 : 0.5,
    };
    return (step.index + withinStep) / stepCount;
  }

  TashkeelLessonState copyWith({
    TashkeelStatus? status,
    TashkeelStep? step,
    String? lessonId,
    List<TashkeelSample>? samples,
    int? sampleIndex,
    String? vowel,
    String? markName,
    String? selectedSyllable,
    TashkeelPlacement? selectedPlacement,
    TashkeelWord? word,
    String? droppedPiece,
    bool? selectedShapeIsAbove,
    bool? markSitsAbove,
    bool? isRecording,
    bool? hasRecorded,
    bool? wordHasRecorded,
    bool? wasWrong,
    int? hearts,
    int? wrongAnswers,
    int? totalAnswers,
    DateTime? startedAt,
    Duration? elapsed,
    bool? audioUnavailable,
    String? errorMessage,
    bool clearSelection = false,
  }) {
    return TashkeelLessonState(
      status: status ?? this.status,
      step: step ?? this.step,
      lessonId: lessonId ?? this.lessonId,
      samples: samples ?? this.samples,
      sampleIndex: sampleIndex ?? this.sampleIndex,
      vowel: vowel ?? this.vowel,
      markName: markName ?? this.markName,
      selectedSyllable:
          clearSelection ? null : (selectedSyllable ?? this.selectedSyllable),
      selectedPlacement:
          clearSelection ? null : (selectedPlacement ?? this.selectedPlacement),
      word: word ?? this.word,
      droppedPiece:
          clearSelection ? null : (droppedPiece ?? this.droppedPiece),
      selectedShapeIsAbove: clearSelection
          ? null
          : (selectedShapeIsAbove ?? this.selectedShapeIsAbove),
      markSitsAbove: markSitsAbove ?? this.markSitsAbove,
      isRecording: isRecording ?? this.isRecording,
      hasRecorded: hasRecorded ?? this.hasRecorded,
      wordHasRecorded: wordHasRecorded ?? this.wordHasRecorded,
      wasWrong: wasWrong ?? this.wasWrong,
      hearts: hearts ?? this.hearts,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      totalAnswers: totalAnswers ?? this.totalAnswers,
      startedAt: startedAt ?? this.startedAt,
      elapsed: elapsed ?? this.elapsed,
      audioUnavailable: audioUnavailable ?? this.audioUnavailable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        step,
        lessonId,
        samples,
        sampleIndex,
        vowel,
        markName,
        selectedSyllable,
        selectedPlacement,
        word,
        droppedPiece,
        selectedShapeIsAbove,
        markSitsAbove,
        isRecording,
        hasRecorded,
        wordHasRecorded,
        wasWrong,
        hearts,
        wrongAnswers,
        totalAnswers,
        startedAt,
        elapsed,
        audioUnavailable,
        errorMessage,
      ];
}
