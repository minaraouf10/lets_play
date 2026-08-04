import '../../domain/entities/leaderboard_data.dart';
import 'leaderboard_entry_model.dart';
import 'podium_place_model.dart';

class LeaderboardDataModel extends LeaderboardData {
  const LeaderboardDataModel({
    required super.podium,
    required super.entries,
  });

  factory LeaderboardDataModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardDataModel(
      podium: (map['podium'] as List<dynamic>?)
              ?.map((e) => PodiumPlaceModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      entries: (map['entries'] as List<dynamic>?)
              ?.map((e) => LeaderboardEntryModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
