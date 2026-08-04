import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/achievements_summary.dart';
import '../../domain/repositories/achievements_repository.dart';
import '../datasources/achievements_local_datasource.dart';

@LazySingleton(as: AchievementsRepository)
class AchievementsRepositoryImpl implements AchievementsRepository {
  final AchievementsLocalDataSource localDataSource;

  AchievementsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, AchievementsSummary>> getSummary() async {
    try {
      final result = await localDataSource.getSummary();
      return Right(result);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
