import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/follower_entry.dart';
import '../entities/leaderboard_data.dart';
import '../entities/leaderboard_tab.dart';

abstract class LeaderboardRepository {
  Future<Either<Failure, LeaderboardData>> getLeaderboard(LeaderboardTab tab);
  Future<Either<Failure, List<FollowerEntry>>> getFollowers();
}
