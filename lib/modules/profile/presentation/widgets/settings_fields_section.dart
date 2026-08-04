import '../../../../core/utils/app_imports.dart';
import 'settings_field.dart';

class SettingsFieldsSection extends StatelessWidget {
  const SettingsFieldsSection({super.key, required this.cubit});

  final SettingsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          children: [
            SettingsField(
              label: 'Username',
              value: state.settings.username,
              onChanged: cubit.updateUsername,
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            SettingsField(
              label: 'Password',
              value: state.settings.password,
              onChanged: cubit.updatePassword,
              obscure: true,
            ),
            const SizedBox(height: AppDimensions.spaceLg),
            SettingsField(
              label: 'Email',
              value: state.settings.email,
              onChanged: cubit.updateEmail,
            ),
          ],
        );
      },
    );
  }
}
