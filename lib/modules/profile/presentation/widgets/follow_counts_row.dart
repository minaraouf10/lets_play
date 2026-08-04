import '../../../../core/utils/app_imports.dart';
import 'follow_count_box.dart';

class FollowCountsRow extends StatelessWidget {
  const FollowCountsRow({
    super.key,
    required this.followersCount,
    required this.followingCount,
  });

  final int followersCount;
  final int followingCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FollowCountBox(
            count: followersCount,
            label: 'Followers',
          ),
        ),
        const SizedBox(width: AppDimensions.spaceMd),
        Expanded(
          child: FollowCountBox(
            count: followingCount,
            label: 'Following',
          ),
        ),
      ],
    );
  }
}
