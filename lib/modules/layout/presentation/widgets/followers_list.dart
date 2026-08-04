import '../../../../core/utils/app_imports.dart';
import '../pages/followers_page.dart';
import 'follower_row.dart';

/// ListView of FollowerRow items with search filtering.
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
    if (followers.isEmpty) {
      return Center(
        child: Text(
          'No followers found',
          style: AppTextStyles.bodyMedium,
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
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
