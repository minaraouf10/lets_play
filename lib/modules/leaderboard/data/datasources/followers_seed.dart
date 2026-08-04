import '../../../profile/data/models/user_stat_model.dart';
import '../../../profile/domain/entities/stat_kind.dart';
import '../models/follower_entry_model.dart';

class FollowersSeed {
  static const List<FollowerEntryModel> data = [
    FollowerEntryModel(
      id: 'f1',
      name: 'Habiba Salam',
      avatarAsset: 'assets/images/profile/user1_icon.png',
      points: 2150,
      badgeLabel: 'Alphabet Genius!',
      stats: [
        UserStatModel(kind: StatKind.energy, value: 15),
        UserStatModel(kind: StatKind.hearts, value: 6),
        UserStatModel(kind: StatKind.points, value: 300),
      ],
    ),
    FollowerEntryModel(
      id: 'f2',
      name: 'Ahmed Hassan',
      avatarAsset: 'assets/images/profile/user1_icon.png',
      points: 1850,
      stats: [
        UserStatModel(kind: StatKind.energy, value: 12),
        UserStatModel(kind: StatKind.hearts, value: 5),
        UserStatModel(kind: StatKind.points, value: 280),
      ],
    ),
    FollowerEntryModel(
      id: 'f3',
      name: 'Sara Mohamed',
      avatarAsset: 'assets/images/profile/user1_icon.png',
      points: 1650,
      stats: [
        UserStatModel(kind: StatKind.energy, value: 10),
        UserStatModel(kind: StatKind.hearts, value: 4),
        UserStatModel(kind: StatKind.points, value: 250),
      ],
    ),
    FollowerEntryModel(
      id: 'f4',
      name: 'Fatima Nour',
      avatarAsset: 'assets/images/profile/profile.png',
      points: 1420,
      stats: [
        UserStatModel(kind: StatKind.energy, value: 9),
        UserStatModel(kind: StatKind.hearts, value: 3),
        UserStatModel(kind: StatKind.points, value: 200),
      ],
    ),
    FollowerEntryModel(
      id: 'f5',
      name: 'Khalid Salah',
      avatarAsset: 'assets/images/profile/user1_icon.png',
      points: 1250,
      stats: [
        UserStatModel(kind: StatKind.energy, value: 8),
        UserStatModel(kind: StatKind.hearts, value: 2),
        UserStatModel(kind: StatKind.points, value: 180),
      ],
    ),
    FollowerEntryModel(
      id: 'f6',
      name: 'Lina Malik',
      avatarAsset: 'assets/images/profile/user1_icon.png',
      points: 980,
      stats: [
        UserStatModel(kind: StatKind.energy, value: 7),
        UserStatModel(kind: StatKind.hearts, value: 2),
        UserStatModel(kind: StatKind.points, value: 150),
      ],
    ),
    FollowerEntryModel(
      id: 'f7',
      name: 'Zain Hassan',
      avatarAsset: 'assets/images/profile/profile.png',
      points: 850,
      stats: [
        UserStatModel(kind: StatKind.energy, value: 6),
        UserStatModel(kind: StatKind.hearts, value: 1),
        UserStatModel(kind: StatKind.points, value: 120),
      ],
    ),
    FollowerEntryModel(
      id: 'f8',
      name: 'Mona Yousef',
      avatarAsset: 'assets/images/profile/user1_icon.png',
      points: 720,
      stats: [
        UserStatModel(kind: StatKind.energy, value: 5),
        UserStatModel(kind: StatKind.hearts, value: 1),
        UserStatModel(kind: StatKind.points, value: 100),
      ],
    ),
  ];
}
