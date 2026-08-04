import 'package:equatable/equatable.dart';

class PodiumPlace extends Equatable {
  const PodiumPlace({
    required this.rank,
    required this.name,
    required this.avatarAsset,
    required this.points,
  });

  final int rank;
  final String name;
  final String avatarAsset;
  final int points;

  @override
  List<Object?> get props => [rank, name, avatarAsset, points];
}
