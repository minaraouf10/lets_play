import '../../../../core/utils/app_imports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
    this.title, {
    super.key,
    this.onSettingsTap,
    this.onSave,
    this.trailing,
  });

  final String title;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onSave;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget;
    if (trailing != null) {
      trailingWidget = trailing;
    } else if (onSettingsTap != null) {
      trailingWidget = IconButton(
        icon: const Icon(Icons.settings_rounded),
        color: AppColors.textSecondary,
        onPressed: onSettingsTap,
      );
    } else if (onSave != null) {
      trailingWidget = IconButton(
        icon: const Icon(Icons.check_rounded),
        color: AppColors.success,
        onPressed: onSave,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.screenTitle),
        trailingWidget ?? const SizedBox(),
      ],
    );
  }
}
