import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../domain/entities/level_entity.dart';
import '../cubit/levels_cubit.dart';
import '../widgets/learning_hud.dart';
import '../widgets/letter_tile.dart';
import '../widgets/level_color_mapper.dart';
import '../widgets/level_header.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceMd,
                vertical: AppDimensions.spaceSm,
              ),
              // Placeholder values; wired to a gamification cubit later.
              child: LearningHud(coins: 13500, hearts: 6, energy: 10),
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
                      return _LevelsList(levels: state.levels);
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

class _LevelsList extends StatelessWidget {
  const _LevelsList({required this.levels});

  final List<LevelEntity> levels;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      itemCount: levels.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppDimensions.spaceLg),
      itemBuilder: (context, index) {
        final level = levels[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LevelHeader(level: level),
            const SizedBox(height: AppDimensions.spaceMd),
            _LessonsGrid(level: level),
          ],
        );
      },
    );
  }
}

class _LessonsGrid extends StatelessWidget {
  const _LessonsGrid({required this.level});

  final LevelEntity level;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: level.lessons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppDimensions.letterGridColumns,
        mainAxisSpacing: AppDimensions.letterGridSpacing,
        crossAxisSpacing: AppDimensions.letterGridSpacing,
      ),
      itemBuilder: (context, index) {
        final lesson = level.lessons[index];
        return LetterTile(
          lesson: lesson,
          accentColor: level.type.color,
          onTap: () {
            context.pushNamed(
              AppRoutes.letterGameName,
              queryParameters: {'lessonId': lesson.id},
            );
          },
        );
      },
    );
  }
}
