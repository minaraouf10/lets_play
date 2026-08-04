import '../../../../core/utils/app_imports.dart';
import '../pages/leaderboard_page.dart';
import 'leaderboard_row.dart';

/// ListView.separated of LeaderboardRow items.
class LeaderboardList extends StatelessWidget {
  const LeaderboardList({
    super.key,
    required this.entries,
    required this.onRowTap,
  });

  final List<LeaderboardEntry> entries;
  final ValueChanged<LeaderboardEntry> onRowTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppDimensions.spaceSm),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return LeaderboardRow(
          entry: entry,
          onTap: () => onRowTap(entry),
        );
      },
    );
  }
}
