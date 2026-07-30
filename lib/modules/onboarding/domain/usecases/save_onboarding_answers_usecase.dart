import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/onboarding_answers.dart';
import '../repositories/onboarding_repository.dart';

class SaveOnboardingParams extends Equatable {
  const SaveOnboardingParams(this.answers);

  final OnboardingAnswers answers;

  @override
  List<Object?> get props => [answers];
}

@lazySingleton
class SaveOnboardingAnswersUseCase
    implements UseCase<Unit, SaveOnboardingParams> {
  SaveOnboardingAnswersUseCase(this._repository);

  final OnboardingRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(SaveOnboardingParams params) {
    return _repository.saveAnswers(params.answers);
  }
}
