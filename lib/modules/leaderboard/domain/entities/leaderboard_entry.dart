import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  const LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.avatarAsset,
    required this.points,
    required this.isCurrentUser,
  });

  final int rank;
  final String name;
  final String avatarAsset;
  final int points;
  final bool isCurrentUser;

  @override
  List<Object?> get props => [rank, name, avatarAsset, points, isCurrentUser];
}
