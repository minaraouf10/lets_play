import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/game_result.dart';
import '../../domain/entities/letter_puzzle.dart';
import '../../domain/repositories/games_repository.dart';
import '../datasources/games_local_datasource.dart';

@LazySingleton(as: GamesRepository)
class GamesRepositoryImpl implements GamesRepository {
  GamesRepositoryImpl(this._local);

  final GamesLocalDataSource _local;

  @override
  Future<Either<Failure, LetterPuzzle>> getLetterPuzzle(String lessonId) async {
    try {
      final puzzle = await _local.getLetterPuzzle(lessonId);
      return Right(puzzle);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveResult(GameResult result) async {
    // MVP: no-op success. Later: write to Hive (offline) then sync to
    // Firestore `progress` collection via an outbox.
    return const Right(unit);
  }
}
