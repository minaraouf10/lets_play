import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/follower_entry.dart';
import '../../domain/entities/leaderboard_data.dart';
import '../../domain/entities/leaderboard_tab.dart';
import '../../domain/repositories/leaderboard_repository.dart';
import '../datasources/leaderboard_local_datasource.dart';

@LazySingleton(as: LeaderboardRepository)
class LeaderboardRepositoryImpl implements LeaderboardRepository {
  LeaderboardRepositoryImpl(this._local);

  final LeaderboardLocalDataSource _local;

  @override
  Future<Either<Failure, LeaderboardData>> getLeaderboard(
    LeaderboardTab tab,
  ) async {
    try {
      final data = await _local.getLeaderboard();
      return Right(data);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<FollowerEntry>>> getFollowers() async {
    try {
      final followers = await _local.getFollowers();
      return Right(followers);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure());
    }
  }
}
