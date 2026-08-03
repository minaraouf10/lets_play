part of 'letter_review_cubit.dart';

enum LetterReviewStatus { loading, ready, error }

enum LetterReviewStep { glyph, bricks, forms }

class LetterReviewState extends Equatable {
  const LetterReviewState({
    this.status = LetterReviewStatus.loading,
    this.step = LetterReviewStep.glyph,
    this.puzzle,
    this.errorMessage,
  });

  final LetterReviewStatus status;
  final LetterReviewStep step;
  final LetterPuzzle? puzzle;
  final String? errorMessage;

  LetterReviewState copyWith({
    LetterReviewStatus? status,
    LetterReviewStep? step,
    LetterPuzzle? puzzle,
    String? errorMessage,
  }) {
    return LetterReviewState(
      status: status ?? this.status,
      step: step ?? this.step,
      puzzle: puzzle ?? this.puzzle,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, step, puzzle, errorMessage];
}
