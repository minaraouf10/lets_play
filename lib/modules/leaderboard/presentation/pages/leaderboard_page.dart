import '../../../../core/utils/app_imports.dart';
import '../cubit/leaderboard_cubit.dart';
import '../widgets/leaderboard_header.dart';
import '../widgets/leaderboard_list.dart';
import '../widgets/leaderboard_segmented_control.dart';
import '../widgets/podium.dart';

/// Leaderboard main screen: podium + segmented control + ranked list.
/// Routes to the followers screen on entry row tap.
class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LeaderboardCubit>()..load(),
      child: const _LeaderboardView(),
    );
  }
}

class _LeaderboardView extends StatelessWidget {
  const _LeaderboardView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
          builder: (context, state) {
            if (state.status == LeaderboardStatus.loading ||
                state.status == LeaderboardStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == LeaderboardStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage ?? 'Error',
                  style: AppTextStyles.bodyMedium,
                ),
              );
            }

            final data = state.data;
            if (data == null) return const SizedBox.shrink();

            return ListView(
              children: [
                LeaderboardHeader(onBack: () => context.pop()),
                const SizedBox(height: AppDimensions.spaceLg),
                Podium(places: data.podium),
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceMd),
                  child: LeaderboardSegmentedControl(
                    selected: state.tab,
                    onChanged: (tab) =>
                        context.read<LeaderboardCubit>().selectTab(tab),
                  ),
                ),
                LeaderboardList(
                  entries: data.entries,
                  onRowTap: (_) =>
                      context.pushNamed(AppRoutes.leaderboardFollowersName),
                ),
                const SizedBox(height: AppDimensions.spaceLg),
              ],
            );
          },
        ),
      ),
    );
  }
}
