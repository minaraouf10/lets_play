import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/dependency_injection/injection.dart';
import '../../domain/entities/level_type.dart';
import '../cubit/lesson_intro_cubit.dart';
import '../widgets/lesson_intro_lesson_step.dart';
import '../widgets/lesson_intro_play_step.dart';

/// Two-step intro shown right before a puzzle starts, reached by tapping an
/// unlocked lesson tile on [LevelsMapPage]: lesson/level info card, then
/// "tap the blocks" instructions.
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
      create: (_) => getIt<LessonIntroCubit>(),
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
