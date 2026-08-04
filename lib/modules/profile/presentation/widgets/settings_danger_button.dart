import '../../../../core/utils/app_imports.dart';

class SettingsDangerButton extends StatelessWidget {
  const SettingsDangerButton(
    this.label, {
    super.key,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.danger),
        ),
        child: Text(label, style: AppTextStyles.dangerButton),
      ),
    );
  }
}
