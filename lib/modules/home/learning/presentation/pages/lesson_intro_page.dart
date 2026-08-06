import '../../../../../core/utils/app_imports.dart';

import '../../data/datasources/level_objectives_data.dart';
import '../cubit/lesson_intro_cubit.dart';
import '../widgets/lesson_intro_lesson_step.dart';
import '../widgets/lesson_intro_level_step.dart';

/// Intro shown right before a puzzle starts, reached by tapping an unlocked
/// lesson tile on [LevelsMapPage]: an optional level objectives card, the
/// lesson/level info card, then the "tap the blocks" instructions.
class LessonIntroPage extends StatelessWidget {
  const LessonIntroPage({
    super.key,
    required this.lessonId,
    required this.levelType,
    required this.lessonNumber,
  });

  final String lessonId;
  final LevelType levelType;
  final int lessonNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LessonIntroCubit>()..start(levelType),
      child: _LessonIntroView(
        lessonId: lessonId,
        levelType: levelType,
        lessonNumber: lessonNumber,
      ),
    );
  }
}

class _LessonIntroView extends StatelessWidget {
  const _LessonIntroView({
    required this.lessonId,
    required this.levelType,
    required this.lessonNumber,
  });

  final String lessonId;
  final LevelType levelType;
  final int lessonNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LessonIntroCubit, LessonIntroState>(
        builder: (context, state) {
          switch (state.step) {
            case LessonIntroStep.level:
              return LessonIntroLevelStep(
                levelType: levelType,
                objectives: objectivesFor(levelType),
                onContinue: () =>
                    context.read<LessonIntroCubit>().continuePressed(),
              );
            case LessonIntroStep.lesson:
              return LessonIntroLessonStep(
                levelType: levelType,
                lessonNumber: lessonNumber,
                onContinue: () =>
                    context.read<LessonIntroCubit>().continuePressed(),
              );
            case LessonIntroStep.play:
              return LessonIntroPlayStep(
                levelType: levelType,
                lessonId: lessonId,
              );
          }
        },
      ),
    );
  }
}
