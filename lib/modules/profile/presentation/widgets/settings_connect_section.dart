import '../../../../core/utils/app_imports.dart';
import 'settings_connect_row.dart';

class SettingsConnectSection extends StatelessWidget {
  const SettingsConnectSection({
    super.key,
    required this.onInstagramTap,
    required this.onFacebookTap,
    required this.onTwitterTap,
  });

  final VoidCallback onInstagramTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onTwitterTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsConnectRow(kind: 'Instagram', onTap: onInstagramTap),
        SettingsConnectRow(kind: 'Facebook', onTap: onFacebookTap),
        SettingsConnectRow(kind: 'Twitter', onTap: onTwitterTap),
      ],
    );
  }
}
