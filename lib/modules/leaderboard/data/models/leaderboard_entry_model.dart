import '../../domain/entities/leaderboard_entry.dart';

class LeaderboardEntryModel extends LeaderboardEntry {
  const LeaderboardEntryModel({
    required super.rank,
    required super.name,
    required super.avatarAsset,
    required super.points,
    required super.isCurrentUser,
  });

  factory LeaderboardEntryModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardEntryModel(
      rank: map['rank'] as int,
      name: map['name'] as String,
      avatarAsset: map['avatarAsset'] as String,
      points: map['points'] as int,
      isCurrentUser: map['isCurrentUser'] as bool? ?? false,
    );
  }
}
