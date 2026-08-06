import 'dart:async';

import '../../data/datasources/letter_names_data.dart';
import '../../data/datasources/number_data.dart';
import '../../domain/usecases/get_letter_puzzle_usecase.dart';
import '../../domain/usecases/save_game_result_usecase.dart';
import '../../../../../core/utils/app_imports.dart';

part 'number_quiz_state.dart';

/// Drives the six-question quiz that closes a Level 3 lesson:
/// true/false, listen & choose, count the bricks, write, pronounce, and pick
/// the number that matches the picture.
///
/// A wrong answer costs a heart and is not accepted, so the player always
/// leaves a question having got it right — the same rule the letter quiz uses.
@injectable
class NumberQuizCubit extends Cubit<NumberQuizState> {
  NumberQuizCubit(this._getPuzzle, this._saveResult, this._audio)
      : super(const NumberQuizState());

  final GetLetterPuzzleUseCase _getPuzzle;
  final SaveGameResultUseCase _saveResult;
  final LetterAudioService _audio;

  /// Started when the quiz loads so the results screen can report a duration.
  DateTime? _startedAt;
  Timer? _recordingTimer;

  /// Every Arabic-Indic digit the option grids draw from.
  static const List<String> _digits = [
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩',
  ];

  Future<void> load(String lessonId) async {
    emit(const NumberQuizState(status: NumberQuizStatus.loading));

    final lesson = numberLessonFor(lessonId);
    if (lesson == null) {
      emit(const NumberQuizState(
        status: NumberQuizStatus.error,
        errorMessage: 'No number lesson for this id',
      ));
      return;
    }

    final result = await _getPuzzle(lessonId);
    result.fold(
      (failure) => emit(NumberQuizState(
        status: NumberQuizStatus.error,
        errorMessage: failure.message,
      )),
      (puzzle) {
        _startedAt = DateTime.now();
        emit(NumberQuizState(
          status: NumberQuizStatus.playing,
          lesson: lesson,
          lessonId: lessonId,
          puzzle: puzzle,
          legoCount: _valueOf(lesson.glyph),
          listenOptions: _gridOptions(lesson.glyph, count: 9),
          countOptions: _rowOptions(lesson.glyph, count: 2),
          pickOptions: _rowOptions(lesson.glyph, count: 3),
        ));
      },
    );
  }

  // ── Questions ─────────────────────────────────────────────────────────

  /// Q1. The card always states the number's real meaning, so 'true' is right.
  void answerStatement({required bool answer}) {
    if (state.status != NumberQuizStatus.playing) return;
    if (state.step != NumberQuizStep.statement) return;
    if (!answer) {
      _loseHeart();
      emit(state.copyWith(statementAnswer: false));
      return;
    }
    emit(state.copyWith(statementAnswer: true));
  }

  /// Q2, Q3 and Q6 all pick a digit; only the taught one is accepted.
  void chooseGlyph(String glyph) {
    if (state.status != NumberQuizStatus.playing) return;
    if (glyph != state.glyph) {
      _loseHeart();
      emit(state.copyWith(selectedGlyph: glyph));
      return;
    }
    emit(state.copyWith(selectedGlyph: glyph));
  }

  /// Q4. Fills [cell] if it is part of the digit; the step is done once every
  /// cell has been covered.
  void touchCell(BlockPosition cell) {
    final puzzle = state.puzzle;
    if (puzzle == null || state.step != NumberQuizStep.write) return;
    if (state.hasWritten) return;
    if (!puzzle.target.contains(cell)) return;
    if (state.filledCells.contains(cell)) return;

    final filled = Set<BlockPosition>.from(state.filledCells)..add(cell);
    emit(state.copyWith(
      filledCells: filled,
      hasWritten: filled.length == puzzle.target.length,
    ));
  }

  /// Q5. No speech recognition behind this — a timed "recording" state only,
  /// matching [WordLessonCubit.startRecording].
  void startRecording() {
    if (state.isRecording || state.hasRecorded) return;
    emit(state.copyWith(isRecording: true));
    _recordingTimer?.cancel();
    _recordingTimer = Timer(
      const Duration(seconds: AppDimensions.wordRecordingSeconds),
      () {
        if (isClosed) return;
        emit(state.copyWith(isRecording: false, hasRecorded: true));
      },
    );
  }

  /// Pronounces the number's Arabic word.
  Future<void> play() async {
    final lesson = state.lesson;
    if (lesson == null) return;
    await _audio.speak(spokenLetterFor(state.lessonId, lesson.wordAr));
    _reportAudioAvailability();
  }

  Future<void> playSlowly() async {
    final lesson = state.lesson;
    if (lesson == null) return;
    await _audio.speakSlowly(spokenLetterFor(state.lessonId, lesson.wordAr));
    _reportAudioAvailability();
  }

  /// Advances to the next question, or finishes the quiz after the last one.
  void continuePressed() {
    if (!state.isStepAnswered) return;

    final isLast = state.step == NumberQuizStep.values.last;
    if (isLast) {
      _saveResult(GameResult(
        lessonId: state.lessonId,
        stars: state.mistakes == 0 ? 3 : (state.mistakes == 1 ? 2 : 1),
        mistakes: state.mistakes,
      ));
      emit(state.copyWith(status: NumberQuizStatus.completed));
      return;
    }

    emit(state.copyWith(
      step: NumberQuizStep.values[state.step.index + 1],
      clearSelection: true,
    ));
  }

  /// How long the quiz took, for the results screen.
  Duration get elapsed => _startedAt == null
      ? Duration.zero
      : DateTime.now().difference(_startedAt!);

  // ── Internals ─────────────────────────────────────────────────────────

  void _loseHeart() {
    emit(state.copyWith(
      hearts: (state.hearts - 1).clamp(0, state.hearts),
      mistakes: state.mistakes + 1,
    ));
  }

  /// Surfaces a missing Arabic voice so the button never fails silently.
  void _reportAudioAvailability() {
    if (isClosed) return;
    final unavailable = !_audio.isArabicAvailable;
    if (unavailable == state.audioUnavailable) return;
    emit(state.copyWith(audioUnavailable: unavailable));
  }

  /// The value of an Arabic-Indic digit, e.g. '١' -> 1. Falls back to 1 for
  /// anything unrecognised so the "count the bricks" step still draws.
  static int _valueOf(String glyph) {
    final index = _digits.indexOf(glyph);
    return index < 0 ? 1 : index + 1;
  }

  /// [count] digits including [correct], laid out deterministically so the
  /// grid never reshuffles on rebuild.
  static List<String> _rowOptions(String correct, {required int count}) {
    final others = _digits.where((d) => d != correct).toList();
    final seed = correct.hashCode.abs();
    final picked = <String>[correct];
    for (var i = 0; picked.length < count && i < others.length; i++) {
      picked.add(others[(seed + i) % others.length]);
    }
    // Rotate so the answer is not always first.
    final offset = seed % picked.length;
    return [...picked.sublist(offset), ...picked.sublist(0, offset)];
  }

  /// Q2's 3x3 grid. Repeats a small set of digits across the nine cells the
  /// way the reference screen does, with the answer appearing three times.
  static List<String> _gridOptions(String correct, {required int count}) {
    final base = _rowOptions(correct, count: 3);
    return [
      for (var i = 0; i < count; i++) base[(i + i ~/ 3) % base.length],
    ];
  }

  @override
  Future<void> close() {
    _recordingTimer?.cancel();
    _audio.stop();
    return super.close();
  }
}
