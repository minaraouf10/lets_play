import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/leaderboard_entry.dart';
import 'leaderboard_row.dart';

/// [ListView.separated] of [LeaderboardRow]s.
class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.entries, this.onRowTap});

  final List<LeaderboardEntry> entries;
  final ValueChanged<LeaderboardEntry>? onRowTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMd,
        vertical: AppDimensions.spaceSm,
      ),
      itemCount: entries.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppDimensions.spaceSm),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return LeaderboardRow(
          entry: entry,
          onTap: onRowTap == null ? null : () => onRowTap!(entry),
        );
      },
    );
  }
}
