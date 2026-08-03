import '../../../../core/utils/app_imports.dart';


/// Icon + numeric value pair used by [LearningHud].
class HudChip extends StatelessWidget {
  const HudChip({super.key, required this.asset, required this.value});

  final String asset;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(asset, height: AppDimensions.hudIconHeight),
        const SizedBox(width: AppDimensions.spaceXs),
        Text(value, style: AppTextStyles.bodyLarge),
      ],
    );
  }
}
