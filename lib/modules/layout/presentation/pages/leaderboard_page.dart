import '../../../../core/utils/app_imports.dart';
import '../widgets/leaderboard_header.dart';
import '../widgets/podium.dart';
import '../widgets/leaderboard_segmented_control.dart';
import '../widgets/leaderboard_list.dart';

/// Leaderboard main screen: podium + segmented control + ranked list.
/// Routes to [FollowersPage] on entry row tap.
class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _LeaderboardView();
  }
}

class _LeaderboardView extends StatefulWidget {
  const _LeaderboardView();

  @override
  State<_LeaderboardView> createState() => _LeaderboardViewState();
}

class _LeaderboardViewState extends State<_LeaderboardView> {
  String _selectedTab = 'friends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          children: [
            const LeaderboardHeader(),
            Podium(
              places: const [
                PodiumPlace(rank: 1, name: 'Alice', avatar: '', points: 2500),
                PodiumPlace(rank: 2, name: 'Bob', avatar: '', points: 2200),
                PodiumPlace(rank: 3, name: 'Charlie', avatar: '', points: 1900),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimensions.spaceMd),
              child: LeaderboardSegmentedControl(
                selectedTab: _selectedTab,
                onChanged: (tab) => setState(() => _selectedTab = tab),
              ),
            ),
            LeaderboardList(
              entries: const [
                LeaderboardEntry(rank: 4, name: 'David', avatar: '', points: 1800),
                LeaderboardEntry(rank: 5, name: 'Eve', avatar: '', points: 1700),
              ],
              onRowTap: (entry) {
                context.pushNamed(AppRoutes.leaderboardFollowersName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PodiumPlace {
  final int rank;
  final String name;
  final String avatar;
  final int points;

  const PodiumPlace({
    required this.rank,
    required this.name,
    required this.avatar,
    required this.points,
  });
}

class LeaderboardEntry {
  final int rank;
  final String name;
  final String avatar;
  final int points;

  const LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.avatar,
    required this.points,
  });
}
