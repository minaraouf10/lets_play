import '../../../../core/utils/app_imports.dart';
import 'widgets_barrel.dart';

class SettingsGeneralSection extends StatelessWidget {
  const SettingsGeneralSection({super.key, required this.cubit});

  final SettingsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(title: 'General'),
            SettingsToggleRow(
              label: 'Sound Effects',
              value: state.settings.soundEffects,
              onChanged: cubit.toggleSoundEffects,
            ),
            SettingsToggleRow(
              label: 'Motivational Messages',
              value: state.settings.motivationalReminders,
              onChanged: cubit.toggleMotivationalMessages,
            ),
            SettingsToggleRow(
              label: 'Daily Practice',
              value: state.settings.friendRequests,
              onChanged: cubit.toggleDailyPractice,
            ),
            SettingsToggleRow(
              label: 'Announcements',
              value: state.settings.newsletterEmails,
              onChanged: cubit.toggleAnnouncements,
            ),
          ],
        );
      },
    );
  }
}
