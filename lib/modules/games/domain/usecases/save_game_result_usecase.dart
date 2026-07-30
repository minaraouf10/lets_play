import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/game_result.dart';
import '../repositories/games_repository.dart';

@lazySingleton
class SaveGameResultUseCase implements UseCase<Unit, GameResult> {
  SaveGameResultUseCase(this._repository);

  final GamesRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(GameResult params) =>
      _repository.saveResult(params);
}
