part of 'feedback_cubit.dart';

enum FeedbackStatus { editing, sending, sent, error }

class FeedbackState extends Equatable {
  const FeedbackState({
    this.status = FeedbackStatus.editing,
    required this.draft,
    this.errorMessage,
  });

  final FeedbackStatus status;
  final FeedbackDraft draft;
  final String? errorMessage;

  FeedbackState copyWith({
    FeedbackStatus? status,
    FeedbackDraft? draft,
    String? errorMessage,
  }) {
    return FeedbackState(
      status: status ?? this.status,
      draft: draft ?? this.draft,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, draft, errorMessage];
}
