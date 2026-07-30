import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/game_result.dart';
import '../entities/letter_puzzle.dart';

abstract class GamesRepository {
  /// Returns the build-the-letter puzzle for a given lesson.
  Future<Either<Failure, LetterPuzzle>> getLetterPuzzle(String lessonId);

  /// Persists the result (local-first; syncs to Firestore later).
  Future<Either<Failure, Unit>> saveResult(GameResult result);
}
