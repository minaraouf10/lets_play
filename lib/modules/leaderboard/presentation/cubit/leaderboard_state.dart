part of 'leaderboard_cubit.dart';

enum LeaderboardStatus { initial, loading, loaded, error }

class LeaderboardState {
  const LeaderboardState({
    this.status = LeaderboardStatus.initial,
    this.data,
    this.tab = LeaderboardTab.leadership,
    this.errorMessage,
  });

  final LeaderboardStatus status;
  final LeaderboardData? data;
  final LeaderboardTab tab;
  final String? errorMessage;

  LeaderboardState copyWith({
    LeaderboardStatus? status,
    LeaderboardData? data,
    LeaderboardTab? tab,
    String? errorMessage,
  }) =>
      LeaderboardState(
        status: status ?? this.status,
        data: data ?? this.data,
        tab: tab ?? this.tab,
        errorMessage: errorMessage,
      );

}
