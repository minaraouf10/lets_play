import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/follower_entry.dart';
import 'follower_row.dart';

/// [ListView.separated] of [FollowerRow]s.
class FollowersList extends StatelessWidget {
  const FollowersList({
    super.key,
    required this.followers,
    required this.onRowTap,
  });

  final List<FollowerEntry> followers;
  final ValueChanged<FollowerEntry> onRowTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMd,
        vertical: AppDimensions.spaceSm,
      ),
      itemCount: followers.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppDimensions.spaceSm),
      itemBuilder: (context, index) {
        final follower = followers[index];
        return FollowerRow(
          follower: follower,
          onTap: () => onRowTap(follower),
        );
      },
    );
  }
}
