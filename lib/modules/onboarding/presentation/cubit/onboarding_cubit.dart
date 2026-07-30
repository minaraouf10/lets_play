import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/onboarding_answers.dart';
import '../../domain/usecases/get_onboarding_questions_usecase.dart';
import '../../domain/usecases/save_onboarding_answers_usecase.dart';
import '../../../../core/utils/usecase.dart';
import 'onboarding_state.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(
    this._getQuestionsUseCase,
    this._saveAnswersUseCase,
  ) : super(const OnboardingState());

  final GetOnboardingQuestionsUseCase _getQuestionsUseCase;
  final SaveOnboardingAnswersUseCase _saveAnswersUseCase;

  Future<void> load() async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final result = await _getQuestionsUseCase(const NoParams());
    result.fold(
      (failure) => emit(state.copyWith(status: OnboardingStatus.error, errorMessage: failure.message)),
      (questions) => emit(state.copyWith(status: OnboardingStatus.ready, questions: questions, currentStepIndex: 0, answers: const OnboardingAnswers())),
    );
  }

  void selectReason(String id) {
    final updated = state.answers.copyWith(reason: id);
    emit(state.copyWith(answers: updated));
    nextStep();
  }

  void selectProficiency(String id) {
    final updated = state.answers.copyWith(proficiency: id);
    emit(state.copyWith(answers: updated));
    nextStep();
  }

  void selectDailyGoal(int minutes) {
    final updated = state.answers.copyWith(dailyGoalMinutes: minutes);
    emit(state.copyWith(answers: updated));
    nextStep();
  }

  Future<void> selectStartingPoint(String id) async {
    final updated = state.answers.copyWith(startingPoint: id, isCompleted: true);
    emit(state.copyWith(answers: updated, status: OnboardingStatus.submitting));
    final result = await _saveAnswersUseCase(SaveOnboardingParams(updated));
    result.fold(
      (failure) => emit(state.copyWith(status: OnboardingStatus.error, errorMessage: failure.message)),
      (_) => emit(state.copyWith(status: OnboardingStatus.completed)),
    );
  }

  void nextStep() {
    if (state.currentStepIndex < state.questions.length - 1) {
      emit(state.copyWith(currentStepIndex: state.currentStepIndex + 1));
    }
  }

  void previousStep() {
    if (state.currentStepIndex > 0) {
      emit(state.copyWith(currentStepIndex: state.currentStepIndex - 1));
    }
  }
}
