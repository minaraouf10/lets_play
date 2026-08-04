import '../../../../core/utils/app_imports.dart';

class SettingsButtonPair extends StatelessWidget {
  const SettingsButtonPair({
    super.key,
    required this.label1,
    required this.label2,
    required this.onTap1,
    required this.onTap2,
  });

  final String label1;
  final String label2;
  final VoidCallback onTap1;
  final VoidCallback onTap2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onTap1,
            child: Text(label1),
          ),
        ),
        const SizedBox(width: AppDimensions.settingsPairSpacing),
        Expanded(
          child: OutlinedButton(
            onPressed: onTap2,
            child: Text(label2),
          ),
        ),
      ],
    );
  }
}
