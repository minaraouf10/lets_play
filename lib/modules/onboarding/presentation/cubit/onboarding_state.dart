import 'package:equatable/equatable.dart';

import '../../domain/entities/onboarding_answers.dart';
import '../../domain/entities/onboarding_question.dart';

enum OnboardingStatus { initial, loading, ready, submitting, completed, error }

class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.questions = const [],
    this.currentStepIndex = 0,
    this.answers = const OnboardingAnswers(),
    this.errorMessage,
  });

  final OnboardingStatus status;
  final List<OnboardingQuestion> questions;
  final int currentStepIndex;
  final OnboardingAnswers answers;
  final String? errorMessage;

  OnboardingState copyWith({
    OnboardingStatus? status,
    List<OnboardingQuestion>? questions,
    int? currentStepIndex,
    OnboardingAnswers? answers,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      answers: answers ?? this.answers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        questions,
        currentStepIndex,
        answers,
        errorMessage,
      ];
}
