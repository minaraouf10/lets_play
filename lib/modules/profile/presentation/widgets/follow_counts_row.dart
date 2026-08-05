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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: AppDimensions.followBoxWidth,
          child: FollowCountBox(
            count: followingCount,
            label: 'Following',
          ),
        ),
        const SizedBox(width: AppDimensions.spaceMd),
        SizedBox(
          width: AppDimensions.followBoxWidth,
          child: FollowCountBox(
            count: followersCount,
            label: 'Followers',
          ),
        ),
      ],
    );
  }
}
