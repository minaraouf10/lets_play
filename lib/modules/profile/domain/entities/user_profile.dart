import 'package:equatable/equatable.dart';

import 'user_stat.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.displayName,
    required this.avatarAsset,
    required this.joinedLabel,
    required this.followingCount,
    required this.followersCount,
    required this.stats,
    this.badgeLabel,
  });

  final String id;
  final String displayName;
  final String avatarAsset;
  final String joinedLabel;
  final int followingCount;
  final int followersCount;
  final List<UserStat> stats;
  final String? badgeLabel;

  @override
  List<Object?> get props => [
    id,
    displayName,
    avatarAsset,
    joinedLabel,
    followingCount,
    followersCount,
    stats,
    badgeLabel,
  ];
}
