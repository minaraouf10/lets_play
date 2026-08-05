import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/achievements_summary.dart';
import '../repositories/achievements_repository.dart';

@injectable
class GetAchievementsUseCase extends UseCase<AchievementsSummary, NoParams> {
  final AchievementsRepository repository;

  GetAchievementsUseCase(this.repository);

  @override
  Future<Either<Failure, AchievementsSummary>> call(NoParams params) {
    return repository.getSummary();
  }
}
