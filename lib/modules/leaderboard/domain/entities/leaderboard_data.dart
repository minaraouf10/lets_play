import 'package:equatable/equatable.dart';

import 'leaderboard_entry.dart';
import 'podium_place.dart';

class LeaderboardData extends Equatable {
  const LeaderboardData({
    required this.podium,
    required this.entries,
  });

  final List<PodiumPlace> podium;
  final List<LeaderboardEntry> entries;

  @override
  List<Object?> get props => [podium, entries];
}
