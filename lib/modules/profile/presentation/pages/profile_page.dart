import '../../../../core/utils/app_imports.dart';
import '../widgets/widgets_barrel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == ProfileStatus.error) {
              return Center(child: Text(state.errorMessage ?? 'Error loading profile'));
            }
            final profile = state.profile;
            if (profile == null) return const SizedBox.shrink();
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 64,
                  floating: true,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: ProfileHeader(
                      'Profile',
                      onSettingsTap: () => context.pushNamed(AppRoutes.profileSettingsName),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
                    child: Column(
                      children: [
                        ProfileAvatar(
                          radius: AppDimensions.profileAvatarLg,
                          asset: profile.avatarAsset,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        Text(profile.displayName, style: AppTextStyles.profileName),
                        Text(
                          profile.joinedLabel,
                          style: AppTextStyles.profileJoined,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        FollowCountsRow(
                          followingCount: profile.followingCount,
                          followersCount: profile.followersCount,
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                        const SectionHeading(title: 'Statistics'),
                        StatTilesRow(stats: profile.stats),
                        const SizedBox(height: AppDimensions.spaceLg),
                        ProfileLinksSection(
                          title: 'Review Progress',
                          links: state.reviewLinks,
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                        ProfileLinksSection(
                          title: 'Find your Friends',
                          links: state.friendLinks,
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
