import '../../../../core/utils/app_imports.dart';
import 'widgets_barrel.dart';

class SettingsAvatarEditor extends StatelessWidget {
  const SettingsAvatarEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          const ProfileAvatar(
            radius: AppDimensions.profileAvatarMd,
            asset: 'assets/images/profile/profile.png',
          ),
          Container(
            width: AppDimensions.profileEditBadge,
            height: AppDimensions.profileEditBadge,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.edit_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
