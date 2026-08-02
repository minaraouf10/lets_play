import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/widgets/app_loading.dart';
import '../cubit/levels_cubit.dart';
import '../widgets/learning_hud.dart';
import '../widgets/levels_list.dart';

/// The learning map. Renders every level header followed by its lesson grid,
/// exactly like the reference screens. Scales to 300 screens by data alone.
class LevelsMapPage extends StatelessWidget {
  const LevelsMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LevelsCubit>()..loadLevels(),
      child: const _LevelsView(),
    );
  }
}

class _LevelsView extends StatelessWidget {
  const _LevelsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(bottom: false,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceMd,
                vertical: AppDimensions.spaceSm,
              ),
              // Placeholder values; wired to a gamification cubit later.
              child: LearningHud(coins: 135, hearts: 6, energy: 10),
            ),
            Expanded(
              child: BlocBuilder<LevelsCubit, LevelsState>(
                builder: (context, state) {
                  switch (state.status) {
                    case LevelsStatus.loading:
                    case LevelsStatus.initial:
                      return const AppLoading();
                    case LevelsStatus.error:
                      return Center(child: Text(state.errorMessage ?? 'Error'));
                    case LevelsStatus.loaded:
                      return LevelsList(levels: state.levels);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
