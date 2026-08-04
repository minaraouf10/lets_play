import '../../domain/repositories/profile_repository.dart';
import '../../../../core/utils/app_imports.dart';

part 'feedback_state.dart';

@injectable
class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(this._repository)
      : super(FeedbackState(
          draft: FeedbackDraft(
            to: '',
            ccBcc: '',
            from: '',
            subject: '',
            body: '',
          ),
        ));

  final ProfileRepository _repository;

  void updateTo(String to) {
    final updated = state.draft.copyWith(to: to);
    emit(state.copyWith(draft: updated));
  }

  void updateCcBcc(String ccBcc) {
    final updated = state.draft.copyWith(ccBcc: ccBcc);
    emit(state.copyWith(draft: updated));
  }

  void updateSubject(String subject) {
    final updated = state.draft.copyWith(subject: subject);
    emit(state.copyWith(draft: updated));
  }

  void updateBody(String body) {
    final updated = state.draft.copyWith(body: body);
    emit(state.copyWith(draft: updated));
  }

  Future<void> send() async {
    emit(state.copyWith(status: FeedbackStatus.sending));
    final result = await _repository.sendFeedback(state.draft);
    result.fold(
      (failure) => emit(state.copyWith(
        status: FeedbackStatus.error,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: FeedbackStatus.sent)),
    );
  }
}
