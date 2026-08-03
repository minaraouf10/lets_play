import '../../../../core/utils/app_imports.dart';


/// Shared placeholder body for tabs that are not implemented yet.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.headingMedium),
          const SizedBox(height: AppDimensions.spaceSm),
          Text('Coming soon', style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
