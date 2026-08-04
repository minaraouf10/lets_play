import '../../../../core/utils/app_imports.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppDimensions.spaceMd,
      vertical: AppDimensions.spaceSm,
    ),
  });

  final String title;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(title, style: AppTextStyles.sectionHeading),
    );
  }
}
