import '../../../../core/utils/app_imports.dart';

class TotalPointsBlock extends StatelessWidget {
  const TotalPointsBlock(this.totalPoints, {super.key});

  final int totalPoints;

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (Match m) => ',',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Total Points',
            style: AppTextStyles.totalPointsLabel,
          ),
          const SizedBox(height: AppDimensions.spaceSm),
          Text(
            _formatNumber(totalPoints),
            style: AppTextStyles.totalPointsValue,
          ),
        ],
      ),
    );
  }
}
