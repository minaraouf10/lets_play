import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/app_loading.dart';
import '../../data/datasources/number_data.dart';
import '../cubit/letter_quiz_cubit.dart';
import '../widgets/game_top_bar.dart';
import '../widgets/quiz_continue_button.dart';
import '../widgets/quiz_listen_step.dart';
import '../widgets/quiz_statement_step.dart';

/// Two-question quiz shown after the letter has been traced.
class LetterQuizPage extends StatelessWidget {
  const LetterQuizPage({
    super.key,
    required this.lessonId,
    required this.letterName,
  });

  final String lessonId;
  final String letterName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LetterQuizCubit>()..load(lessonId),
      child: _LetterQuizView(lessonId: lessonId, letterName: letterName),
    );
  }
}

class _LetterQuizView extends StatelessWidget {
  const _LetterQuizView({required this.lessonId, required this.letterName});

  final String lessonId;
  final String letterName;

  void _finish(BuildContext context) {
    // Numbers have no word lesson to hand off to, so they end on the
    // celebration screen and return to the levels map.
    final isNumber = isNumberLesson(lessonId);
    context.pushReplacementNamed(
      AppRoutes.greatJobName,
      queryParameters: {
        'lessonId': lessonId,
        'userName': 'Malak',
        'levelType': levelTypeForLessonId(lessonId).name,
        'nextRoute':
            isNumber ? AppRoutes.levelsName : AppRoutes.wordLessonName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<LetterQuizCubit, LetterQuizState>(
        builder: (context, state) {
          switch (state.status) {
            case QuizStatus.loading:
              return const AppLoading();
            case QuizStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case QuizStatus.completed:
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _finish(context),
              );
              return const AppLoading();
            case QuizStatus.choosing:
            case QuizStatus.judging:
              final cubit = context.read<LetterQuizCubit>();
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
                        child: state.status == QuizStatus.choosing
                            ? SingleChildScrollView(
                                child: QuizListenStep(
                                  options: state.options,
                                  selectedOptionId: state.selectedOptionId,
                                  correctId: state.target?.id ?? '',
                                  audioUnavailable: state.audioUnavailable,
                                  onPlay: cubit.playLetter,
                                  onPlaySlowly: cubit.playLetterSlowly,
                                  onSelect: cubit.chooseOption,
                                ),
                              )
                            : QuizStatementStep(
                                statementLetter: state.statementLetter!,
                                claimName: letterName,
                                answer: state.statementAnswer,
                                isCorrect: state.isStatementCorrect,
                                onAnswer: (v) =>
                                    cubit.answerStatement(answer: v),
                              ),
                      ),
                      const SizedBox(height: AppDimensions.spaceMd),
                      QuizContinueButton(
                        enabled: state.status == QuizStatus.choosing
                            ? state.isChoiceCorrect
                            : state.isStatementCorrect,
                        onPressed: state.status == QuizStatus.choosing
                            ? cubit.confirmChoice
                            : cubit.finish,
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
}
