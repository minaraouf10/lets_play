import '../../domain/entities/podium_place.dart';

class PodiumPlaceModel extends PodiumPlace {
  const PodiumPlaceModel({
    required super.rank,
    required super.name,
    required super.avatarAsset,
    required super.points,
  });

  factory PodiumPlaceModel.fromMap(Map<String, dynamic> map) {
    return PodiumPlaceModel(
      rank: map['rank'] as int,
      name: map['name'] as String,
      avatarAsset: map['avatarAsset'] as String,
      points: map['points'] as int,
    );
  }
}
