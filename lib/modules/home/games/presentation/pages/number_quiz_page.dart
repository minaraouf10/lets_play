import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/app_loading.dart';
import '../../domain/entities/lesson_result.dart';
import '../cubit/number_quiz_cubit.dart';
import '../widgets/game_top_bar.dart';
import '../widgets/number_quiz_steps.dart';
import '../widgets/quiz_continue_button.dart';
import 'lesson_complete_page.dart';

/// Six-question quiz that closes a Level 3 lesson, shown after the number has
/// been formed, reviewed and traced.
///
/// Flow: … → LetterTrace → GreatJob → **NumberQuizPage** → LessonComplete
class NumberQuizPage extends StatelessWidget {
  const NumberQuizPage({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NumberQuizCubit>()..load(lessonId),
      child: const _NumberQuizView(),
    );
  }
}

class _NumberQuizView extends StatelessWidget {
  const _NumberQuizView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<NumberQuizCubit, NumberQuizState>(
        builder: (context, state) {
          switch (state.status) {
            case NumberQuizStatus.loading:
              return const AppLoading();
            case NumberQuizStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case NumberQuizStatus.completed:
              final cubit = context.read<NumberQuizCubit>();
              return LessonCompletePage(
                userName: 'Malak',
                levelType: levelTypeForLessonId(state.lessonId),
                result: LessonResult(
                  points: 5380,
                  accuracy: state.accuracy,
                  elapsed: cubit.elapsed,
                ),
              );
            case NumberQuizStatus.playing:
              final cubit = context.read<NumberQuizCubit>();
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.spaceMd),
                  child: Column(
                    children: [
                      GameTopBar(
                        hearts: state.hearts,
                        progress: state.progress,
                        heartsLeading: true,
                        onClose: () => context.pop(),
                      ),
                      Expanded(
                        // The statement and write steps lay themselves out to
                        // the available height; the rest are tall enough to
                        // need scrolling on small screens.
                        child: switch (state.step) {
                          NumberQuizStep.statement ||
                          NumberQuizStep.write =>
                            _stepBody(context, state, cubit),
                          _ => SingleChildScrollView(
                              child: _stepBody(context, state, cubit),
                            ),
                        },
                      ),
                      const SizedBox(height: AppDimensions.spaceMd),
                      QuizContinueButton(
                        enabled: state.isStepAnswered,
                        onPressed: cubit.continuePressed,
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  Widget _stepBody(
    BuildContext context,
    NumberQuizState state,
    NumberQuizCubit cubit,
  ) {
    final lesson = state.lesson!;

    return switch (state.step) {
      NumberQuizStep.statement => NumberStatementStep(
          lesson: lesson,
          answer: state.statementAnswer,
          onAnswer: (v) => cubit.answerStatement(answer: v),
        ),
      NumberQuizStep.listen => NumberListenStep(
          lesson: lesson,
          options: state.listenOptions,
          selectedGlyph: state.selectedGlyph,
          audioUnavailable: state.audioUnavailable,
          onPlay: cubit.play,
          onPlaySlowly: cubit.playSlowly,
          onSelect: cubit.chooseGlyph,
        ),
      NumberQuizStep.count => NumberCountStep(
          lesson: lesson,
          legoCount: state.legoCount,
          options: state.countOptions,
          selectedGlyph: state.selectedGlyph,
          audioUnavailable: state.audioUnavailable,
          onPlay: cubit.play,
          onPlaySlowly: cubit.playSlowly,
          onSelect: cubit.chooseGlyph,
        ),
      NumberQuizStep.write => NumberWriteStep(
          puzzle: state.puzzle!,
          filledCells: state.filledCells,
          onTouchCell: cubit.touchCell,
        ),
      NumberQuizStep.pronounce => NumberPronounceStep(
          lesson: lesson,
          isRecording: state.isRecording,
          hasRecorded: state.hasRecorded,
          audioUnavailable: state.audioUnavailable,
          onPlay: cubit.play,
          onRecord: cubit.startRecording,
        ),
      NumberQuizStep.pick => NumberPickStep(
          lesson: lesson,
          legoCount: state.legoCount,
          options: state.pickOptions,
          selectedGlyph: state.selectedGlyph,
          onSelect: cubit.chooseGlyph,
        ),
    };
  }
}
