import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/onboarding_answers.dart';
import '../entities/onboarding_question.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, List<OnboardingQuestion>>> getQuestions();
  Future<Either<Failure, Unit>> saveAnswers(OnboardingAnswers answers);
  Future<Either<Failure, OnboardingAnswers>> getSavedAnswers();
  Future<Either<Failure, bool>> isOnboardingCompleted();
  bool get isOnboardingCompletedSync;
}
