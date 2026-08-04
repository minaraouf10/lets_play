import '../../../../core/utils/app_imports.dart';

class SettingsConnectRow extends StatelessWidget {
  const SettingsConnectRow({
    super.key,
    required this.kind,
    required this.onTap,
  });

  final String kind;
  final VoidCallback onTap;

  String get _icon {
    switch (kind.toLowerCase()) {
      case 'instagram':
        return 'assets/images/profile/instgram_icon.svg';
      case 'facebook':
        return 'assets/images/profile/facebook_icon.svg';
      case 'twitter':
        return 'assets/images/profile/twitter_icon.svg';
      default:
        return 'assets/images/profile/instgram_icon.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceSm),
        child: Row(
          children: [
            SvgPicture.asset(_icon, width: 24, height: 24),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(
              child: Text(kind, style: AppTextStyles.linkRowLabel),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
