import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/entities/level_entity.dart';
import '../../domain/repositories/learning_repository.dart';
import '../datasources/learning_local_datasource.dart';

@LazySingleton(as: LearningRepository)
class LearningRepositoryImpl implements LearningRepository {
  LearningRepositoryImpl(this._local);

  final LearningLocalDataSource _local;

  @override
  Future<Either<Failure, List<LevelEntity>>> getLevels() async {
    try {
      final levels = await _local.getLevels();
      return Right(levels);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }
}
