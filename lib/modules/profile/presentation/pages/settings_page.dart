import '../../../../core/utils/app_imports.dart';
import '../widgets/widgets_barrel.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsCubit>()..loadSettings(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state.status == SettingsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 64,
                  floating: true,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
                    child: ProfileHeader(
                      'Settings',
                      onSave: () => context.read<SettingsCubit>().save(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
                    child: Column(
                      children: [
                        const SizedBox(height: AppDimensions.spaceLg),
                        const SettingsAvatarEditor(),
                        const SizedBox(height: AppDimensions.spaceLg),
                        SettingsFieldsSection(cubit: context.read<SettingsCubit>()),
                        const SizedBox(height: AppDimensions.settingsSectionGap),
                        SettingsButtonPair(
                          label1: 'Terms',
                          label2: 'Privacy Policy',
                          onTap1: () => _showComingSoon(context),
                          onTap2: () => _showComingSoon(context),
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                        SettingsDangerButton(
                          'Delete Account',
                          onTap: () => _showComingSoon(context),
                        ),
                        const SizedBox(height: AppDimensions.settingsSectionGap),
                        const SectionHeading(title: 'Connect Social'),
                        SettingsConnectSection(
                          onInstagramTap: () => _showComingSoon(context),
                          onFacebookTap: () => _showComingSoon(context),
                          onTwitterTap: () => _showComingSoon(context),
                        ),
                        const SizedBox(height: AppDimensions.settingsSectionGap),
                        SettingsGeneralSection(cubit: context.read<SettingsCubit>()),
                        const SizedBox(height: AppDimensions.spaceLg),
                        SettingsButtonPair(
                          label1: 'Help Center',
                          label2: 'Feedback',
                          onTap1: () => context.pushNamed(AppRoutes.settingsHelpName),
                          onTap2: () => context.pushNamed(AppRoutes.settingsFeedbackName),
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                        SettingsDangerButton(
                          'Sign Out',
                          onTap: () => _showComingSoon(context),
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showComingSoon(BuildContext context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon!')),
    );