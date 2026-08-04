import '../../../../core/utils/app_imports.dart';

class FollowCountBox extends StatelessWidget {
  const FollowCountBox({
    super.key,
    required this.count,
    required this.label,
  });

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.followBoxHeight,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$count', style: AppTextStyles.followCount),
          const SizedBox(height: AppDimensions.spaceXs),
          Text(label, style: AppTextStyles.followLabel),
        ],
      ),
    );
  }
}
