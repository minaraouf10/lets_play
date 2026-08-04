import '../../../profile/data/models/user_stat_model.dart';
import '../../domain/entities/follower_entry.dart';

class FollowerEntryModel extends FollowerEntry {
  const FollowerEntryModel({
    required super.id,
    required super.name,
    required super.avatarAsset,
    required super.points,
    super.badgeLabel,
    required super.stats,
  });

  factory FollowerEntryModel.fromMap(Map<String, dynamic> map) {
    return FollowerEntryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      avatarAsset: map['avatarAsset'] as String,
      points: map['points'] as int,
      badgeLabel: map['badgeLabel'] as String?,
      stats: (map['stats'] as List<dynamic>?)
              ?.map((e) => UserStatModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
