import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/level_entity.dart';
import '../repositories/learning_repository.dart';

@lazySingleton
class GetLevelsUseCase implements UseCase<List<LevelEntity>, NoParams> {
  GetLevelsUseCase(this._repository);

  final LearningRepository _repository;

  @override
  Future<Either<Failure, List<LevelEntity>>> call(NoParams params) =>
      _repository.getLevels();
}
