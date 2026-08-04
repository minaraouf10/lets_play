import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/follower_entry.dart';
import '../repositories/leaderboard_repository.dart';

@lazySingleton
class GetFollowersUseCase
    implements UseCase<List<FollowerEntry>, NoParams> {
  GetFollowersUseCase(this._repository);

  final LeaderboardRepository _repository;

  @override
  Future<Either<Failure, List<FollowerEntry>>> call(NoParams params) =>
      _repository.getFollowers();
}
