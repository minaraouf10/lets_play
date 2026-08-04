import 'package:equatable/equatable.dart';

import '../../../profile/domain/entities/user_stat.dart';

class FollowerEntry extends Equatable {
  const FollowerEntry({
    required this.id,
    required this.name,
    required this.avatarAsset,
    required this.points,
    this.badgeLabel,
    required this.stats,
  });

  final String id;
  final String name;
  final String avatarAsset;
  final int points;
  final String? badgeLabel;
  final List<UserStat> stats;

  @override
  List<Object?> get props => [id, name, avatarAsset, points, badgeLabel, stats];
}
