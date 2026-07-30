import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/onboarding_answers.dart';
import '../../domain/entities/onboarding_question.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';
import '../datasources/onboarding_remote_datasource.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(
    this._local, [
    this._remote,
  ]);

  final OnboardingLocalDataSource _local;
  final OnboardingRemoteDataSource? _remote;

  // Sync flag cached after first load.
  bool _cachedCompleted = false;

  @override
  Future<Either<Failure, List<OnboardingQuestion>>> getQuestions() async {
    try {
      // In MVP we use only local seed questions.
      final questions = await _local.getQuestions();
      return Right(questions);
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveAnswers(OnboardingAnswers answers) async {
    try {
      await _local.saveAnswers(answers);
      // Attempt remote sync, ignore errors to keep offline flow.
      try {
        await _remote?.saveAnswers(answers);
      } catch (_) {}
      _cachedCompleted = answers.isCompleted;
      return const Right(unit);
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, OnboardingAnswers>> getSavedAnswers() async {
    try {
      final answers = await _local.getSavedAnswers();
      return Right(answers);
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() async {
    try {
      final completed = await _local.isOnboardingCompleted();
      _cachedCompleted = completed;
      return Right(completed);
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  bool get isOnboardingCompletedSync => _cachedCompleted;
}
