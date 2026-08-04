import '../models/leaderboard_data_model.dart';
import '../models/leaderboard_entry_model.dart';
import '../models/podium_place_model.dart';

class LeaderboardSeed {
  static const LeaderboardDataModel data = LeaderboardDataModel(
    podium: [
      PodiumPlaceModel(
        rank: 2,
        name: 'Ahmed Hassan',
        avatarAsset: 'assets/images/profile/user1_icon.png',
        points: 1850,
      ),
      PodiumPlaceModel(
        rank: 1,
        name: 'You',
        avatarAsset: 'assets/images/profile/profile.png',
        points: 2500,
      ),
      PodiumPlaceModel(
        rank: 3,
        name: 'Sara Mohamed',
        avatarAsset: 'assets/images/profile/user1_icon.png',
        points: 1650,
      ),
    ],
    entries: [
      LeaderboardEntryModel(
        rank: 1,
        name: 'You',
        avatarAsset: 'assets/images/profile/profile.png',
        points: 2500,
        isCurrentUser: true,
      ),
      LeaderboardEntryModel(
        rank: 2,
        name: 'Ahmed Hassan',
        avatarAsset: 'assets/images/profile/user1_icon.png',
        points: 1850,
        isCurrentUser: false,
      ),
      LeaderboardEntryModel(
        rank: 3,
        name: 'Sara Mohamed',
        avatarAsset: 'assets/images/profile/user1_icon.png',
        points: 1650,
        isCurrentUser: false,
      ),
      LeaderboardEntryModel(
        rank: 4,
        name: 'Fatima Nour',
        avatarAsset: 'assets/images/profile/user1_icon.png',
        points: 1420,
        isCurrentUser: false,
      ),
      LeaderboardEntryModel(
        rank: 5,
        name: 'Khalid Salah',
        avatarAsset: 'assets/images/profile/profile.png',
        points: 1250,
        isCurrentUser: false,
      ),
      LeaderboardEntryModel(
        rank: 6,
        name: 'Lina Malik',
        avatarAsset: 'assets/images/profile/user1_icon.png',
        points: 980,
        isCurrentUser: false,
      ),
      LeaderboardEntryModel(
        rank: 7,
        name: 'Zain Hassan',
        avatarAsset: 'assets/images/profile/user1_icon.png',
        points: 850,
        isCurrentUser: false,
      ),
      LeaderboardEntryModel(
        rank: 8,
        name: 'Mona Yousef',
        avatarAsset: 'assets/images/profile/profile.png',
        points: 720,
        isCurrentUser: false,
      ),
    ],
  );
}
