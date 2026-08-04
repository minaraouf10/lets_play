import '../../../../core/utils/app_imports.dart';

class RewardsBanner extends StatelessWidget {
  const RewardsBanner(this.bannerText);

  final String bannerText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.rewardsBannerHeight,
      child: NeoContainer(
        color: AppColors.rewardsBanner,
        child: Center(
          child: Text(
            bannerText,
            style: AppTextStyles.bannerText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
