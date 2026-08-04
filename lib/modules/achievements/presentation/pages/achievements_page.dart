import 'package:game_test/modules/achievements/presentation/cubit/achievements_cubit.dart';
import 'package:game_test/modules/learning/presentation/widgets/learning_hud.dart';

import '../../../../core/utils/app_imports.dart';
import '../widgets/total_points_block.dart';
import '../widgets/castle_illustration.dart';
import '../widgets/rewards_banner.dart';
import '../widgets/rewards_row.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AchievementsCubit>()..load(),
      child: const _AchievementsView(),
    );
  }
}

class _AchievementsView extends StatelessWidget {
  const _AchievementsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AchievementsCubit, AchievementsState>(
      builder: (context, state) {
        if (state.status == AchievementsStatus.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.status == AchievementsStatus.error) {
          return Scaffold(
            body: Center(child: Text(state.errorMessage ?? 'Error')),
          );
        }

        final summary = state.summary;
        if (summary == null) {
          return const Scaffold(
            body: Center(child: Text('No data')),
          );
        }

        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceLg,
                vertical: AppDimensions.spaceLg,
              ),
              children: [
                LearningHud(
                  energy: summary.energy,
                  hearts: summary.hearts,
                  showCoins: false,
                ),
                const SizedBox(height: AppDimensions.spaceLg),
                TotalPointsBlock(summary.totalPoints),
                const SizedBox(height: AppDimensions.spaceLg),
                const CastleIllustration(),
                const SizedBox(height: AppDimensions.spaceLg),
                RewardsBanner(summary.bannerText),
                const SizedBox(height: AppDimensions.spaceLg),
                RewardsRow(summary.rewards),
                const SizedBox(height: AppDimensions.spaceLg),
              ],
            ),
          ),
        );
      },
    );
  }
}
