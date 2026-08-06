part of 'letter_review_cubit.dart';

enum LetterReviewStatus { loading, ready, error }

/// The third step is level-dependent: letters end on their positional forms,
/// numbers on the "listen and read" card. [LetterReviewState.isNumber] picks
/// between them, so the steps stay a plain linear sequence.
enum LetterReviewStep { glyph, bricks, forms }

class LetterReviewState extends Equatable {
  const LetterReviewState({
    this.status = LetterReviewStatus.loading,
    this.step = LetterReviewStep.glyph,
    this.puzzle,
    this.isNumber = false,
    this.audioUnavailable = false,
    this.errorMessage,
  });

  final LetterReviewStatus status;
  final LetterReviewStep step;
  final LetterPuzzle? puzzle;

  /// True for Level 3 lessons, which swap the forms card for the sound card.
  final bool isNumber;

  /// True when the device has no Arabic voice, so the speaker stays silent.
  final bool audioUnavailable;
  final String? errorMessage;

  LetterReviewState copyWith({
    LetterReviewStatus? status,
    LetterReviewStep? step,
    LetterPuzzle? puzzle,
    bool? isNumber,
    bool? audioUnavailable,
    String? errorMessage,
  }) {
    return LetterReviewState(
      status: status ?? this.status,
      step: step ?? this.step,
      puzzle: puzzle ?? this.puzzle,
      isNumber: isNumber ?? this.isNumber,
      audioUnavailable: audioUnavailable ?? this.audioUnavailable,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, step, puzzle, isNumber, audioUnavailable, errorMessage];
}
