import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/letter_puzzle.dart';
import '../repositories/games_repository.dart';

@lazySingleton
class GetLetterPuzzleUseCase implements UseCase<LetterPuzzle, String> {
  GetLetterPuzzleUseCase(this._repository);

  final GamesRepository _repository;

  @override
  Future<Either<Failure, LetterPuzzle>> call(String lessonId) =>
      _repository.getLetterPuzzle(lessonId);
}
