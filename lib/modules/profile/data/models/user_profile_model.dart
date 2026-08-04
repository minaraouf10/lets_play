import '../../domain/entities/user_profile.dart';
import 'user_stat_model.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.displayName,
    required super.avatarAsset,
    required super.joinedLabel,
    required super.followingCount,
    required super.followersCount,
    required super.stats,
    super.badgeLabel,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] as String,
      displayName: map['displayName'] as String,
      avatarAsset: map['avatarAsset'] as String,
      joinedLabel: map['joinedLabel'] as String,
      followingCount: map['followingCount'] as int,
      followersCount: map['followersCount'] as int,
      badgeLabel: map['badgeLabel'] as String?,
      stats: (map['stats'] as List<dynamic>)
          .map((e) => UserStatModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
