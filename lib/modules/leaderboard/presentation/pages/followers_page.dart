import '../../../../core/utils/app_imports.dart';
import '../cubit/followers_cubit.dart';
import '../widgets/follower_detail_overlay.dart';
import '../widgets/followers_list.dart';

/// Followers screen: search field + followers list, with a detail overlay
/// shown on row tap.
class FollowersPage extends StatelessWidget {
  const FollowersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FollowersCubit>()..load(),
      child: const _FollowersView(),
    );
  }
}

class _FollowersView extends StatelessWidget {
  const _FollowersView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowersCubit, FollowersState>(
      builder: (context, state) {
        final cubit = context.read<FollowersCubit>();

        return Stack(
          children: [
            Scaffold(
              body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    _FollowersHeader(onBack: () => context.pop()),
                    Padding(
                      padding: const EdgeInsets.all(AppDimensions.spaceMd),
                      child: AppSearchField(
                        hintText: 'Search',
                        onChanged: cubit.search,
                      ),
                    ),
                    Expanded(child: _buildBody(state, cubit)),
                  ],
                ),
              ),
            ),
            if (state.selectedFollower != null)
              FollowerDetailOverlay(
                follower: state.selectedFollower!,
                onDismiss: cubit.dismissDetail,
              ),
          ],
        );
      },
    );
  }

  Widget _buildBody(FollowersState state, FollowersCubit cubit) {
    if (state.status == FollowersStatus.loading ||
        state.status == FollowersStatus.initial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == FollowersStatus.error) {
      return Center(
        child: Text(
          state.errorMessage ?? 'Error',
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    return FollowersList(
      followers: state.visibleFollowers,
      onRowTap: (follower) => cubit.selectFollower(follower.id),
    );
  }
}

/// Back chevron + "Followers" title.
class _FollowersHeader extends StatelessWidget {
  const _FollowersHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMd,
        vertical: AppDimensions.spaceSm,
      ),
      child: Row(
        children: [
          InkResponse(
            onTap: onBack,
            radius: AppDimensions.navBarTapRadius,
            child: const Padding(
              padding: EdgeInsets.all(AppDimensions.spaceSm),
              child: Icon(Icons.chevron_left),
            ),
          ),
          const Spacer(),
          Text('Followers', style: AppTextStyles.screenTitle),
          const Spacer(),
          const SizedBox(width: AppDimensions.navBarTapRadius),
        ],
      ),
    );
  }
}
