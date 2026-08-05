import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../entities/level_entity.dart';

abstract class LearningRepository {
  /// Returns all levels with their sample lessons.
  /// Offline-first: served from the local datasource in the MVP; a remote
  /// (Firestore) source can be layered in later behind the same contract.
  Future<Either<Failure, List<LevelEntity>>> getLevels();
}
