import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/profile_link_kind.dart';

class ProfileLinkRow extends StatelessWidget {
  const ProfileLinkRow({
    super.key,
    required this.kind,
    required this.label,
    required this.iconAsset,
    required this.isImplemented,
    this.onTap,
  });

  final ProfileLinkKind kind;
  final String label;
  final String iconAsset;
  final bool isImplemented;
  final VoidCallback? onTap;

  void _handleTap(BuildContext context) {
    if (isImplemented && onTap != null) {
      onTap!();
    } else if (!isImplemented) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Coming soon'),
          duration: const Duration(milliseconds: 1500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context),
      child: Container(
        height: AppDimensions.profileLinkRowHeight,
        margin: const EdgeInsets.only(bottom: AppDimensions.spaceSm),
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconAsset,
              width: AppDimensions.iconMd,
              height: AppDimensions.iconMd,
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Expanded(
              child: Text(label, style: AppTextStyles.linkRowLabel),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: AppDimensions.iconMd,
            ),
          ],
        ),
      ),
    );
  }
}
