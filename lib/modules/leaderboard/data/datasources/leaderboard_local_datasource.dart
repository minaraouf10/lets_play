import 'package:injectable/injectable.dart';

import '../models/follower_entry_model.dart';
import '../models/leaderboard_data_model.dart';
import 'followers_seed.dart';
import 'leaderboard_seed.dart';

abstract class LeaderboardLocalDataSource {
  Future<LeaderboardDataModel> getLeaderboard();
  Future<List<FollowerEntryModel>> getFollowers();
}

@LazySingleton(as: LeaderboardLocalDataSource)
class LeaderboardLocalDataSourceImpl implements LeaderboardLocalDataSource {
  @override
  Future<LeaderboardDataModel> getLeaderboard() async {
    return LeaderboardSeed.data;
  }

  @override
  Future<List<FollowerEntryModel>> getFollowers() async {
    return FollowersSeed.data;
  }
}
