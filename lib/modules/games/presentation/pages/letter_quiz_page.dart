import '../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/app_loading.dart';
import '../cubit/letter_quiz_cubit.dart';
import '../widgets/game_progress_bar.dart';
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
    context.pushReplacementNamed(
      AppRoutes.greatJobName,
      queryParameters: {
        'lessonId': lessonId,
        'userName': 'Malak',
        'nextRoute': AppRoutes.levelsName,
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
                      _QuizTopBar(
                        hearts: state.hearts,
                        progress: state.progress,
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

class _QuizTopBar extends StatelessWidget {
  const _QuizTopBar({required this.hearts, required this.progress});

  final int hearts;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: AppColors.textSecondary),
          onPressed: () => context.pop(),
        ),
        Icon(
          Icons.favorite_rounded,
          color: AppColors.heart,
          size: AppDimensions.iconMd,
        ),
        const SizedBox(width: AppDimensions.spaceXs),
        Text('$hearts', style: AppTextStyles.bodySmall),
        const SizedBox(width: AppDimensions.spaceSm),
        Expanded(child: GameProgressBar(progress: progress)),
      ],
    );
  }
}
