import '../../../../core/utils/app_imports.dart';
import '../widgets/leaderboard_header.dart';
import '../widgets/followers_list.dart';
import '../widgets/follower_detail_overlay.dart';

/// Followers screen: search field + followers list with overlay detail view.
class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _FollowersView();
  }
}

class _FollowersView extends StatefulWidget {
  const _FollowersView();

  @override
  State<_FollowersView> createState() => _FollowersViewState();
}

class _FollowersViewState extends State<_FollowersView> {
  String _searchQuery = '';
  FollowerEntry? _selectedFollower;

  List<FollowerEntry> get _visibleFollowers {
    final allFollowers = const [
      FollowerEntry(name: 'Alice', avatar: '', points: 2500),
      FollowerEntry(name: 'Bob', avatar: '', points: 2200),
      FollowerEntry(name: 'Charlie', avatar: '', points: 1900),
    ];
    if (_searchQuery.isEmpty) return allFollowers;
    return allFollowers
        .where((f) => f.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                const LeaderboardHeader(),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceMd),
                  child: AppSearchField(
                    onChanged: (query) {
                      setState(() => _searchQuery = query);
                    },
                    hintText: 'Search followers',
                  ),
                ),
                Expanded(
                  child: FollowersList(
                    followers: _visibleFollowers,
                    onRowTap: (follower) {
                      setState(() => _selectedFollower = follower);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_selectedFollower != null)
          FollowerDetailOverlay(
            follower: _selectedFollower!,
            onDismiss: () {
              setState(() => _selectedFollower = null);
            },
          ),
      ],
    );
  }
}

class FollowerEntry {
  final String name;
  final String avatar;
  final int points;

  const FollowerEntry({
    required this.name,
    required this.avatar,
    required this.points,
  });
}
