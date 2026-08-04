import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/leaderboard_data.dart';
import '../entities/leaderboard_tab.dart';
import '../repositories/leaderboard_repository.dart';

@lazySingleton
class GetLeaderboardUseCase
    implements UseCase<LeaderboardData, GetLeaderboardParams> {
  GetLeaderboardUseCase(this._repository);

  final LeaderboardRepository _repository;

  @override
  Future<Either<Failure, LeaderboardData>> call(GetLeaderboardParams params) =>
      _repository.getLeaderboard(params.tab);
}

class GetLeaderboardParams extends Equatable {
  const GetLeaderboardParams({required this.tab});

  final LeaderboardTab tab;

  @override
  List<Object?> get props => [tab];
}
