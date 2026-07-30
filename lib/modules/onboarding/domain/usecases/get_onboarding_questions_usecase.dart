import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/onboarding_question.dart';
import '../repositories/onboarding_repository.dart';

@lazySingleton
class GetOnboardingQuestionsUseCase
    implements UseCase<List<OnboardingQuestion>, NoParams> {
  GetOnboardingQuestionsUseCase(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<Either<Failure, List<OnboardingQuestion>>> call(NoParams params) {
    return _repository.getQuestions();
  }
}
