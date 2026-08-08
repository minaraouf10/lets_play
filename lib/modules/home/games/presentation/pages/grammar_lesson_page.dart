import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/app_loading.dart';
import '../../domain/entities/grammar_lesson.dart';
import '../cubit/grammar_lesson_cubit.dart';
import '../widgets/common/game_top_bar.dart';
import '../widgets/grammar/grammar_steps.dart';
import '../widgets/quiz/quiz_continue_button.dart';

/// The Level 4 grammar section that opens a word lesson: what the word types
/// are, picking nouns out of a set, and matching a word to its picture.
///
/// Flow: LessonIntro → **GrammarLessonPage** → WordLessonPage → GreatJob
class GrammarLessonPage extends StatelessWidget {
  const GrammarLessonPage({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GrammarLessonCubit>()..load(lessonId),
      child: _GrammarLessonView(lessonId: lessonId),
    );
  }
}

class _GrammarLessonView extends StatelessWidget {
  const _GrammarLessonView({required this.lessonId});

  final String lessonId;

  /// Hands off to the word steps once the grammar section is done.
  void _toWordLesson(BuildContext context) {
    context.pushReplacementNamed(
      AppRoutes.wordLessonName,
      queryParameters: {'lessonId': lessonId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<GrammarLessonCubit, GrammarLessonState>(
        builder: (context, state) {
          switch (state.status) {
            case GrammarStatus.loading:
              return const AppLoading();
            case GrammarStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case GrammarStatus.completed:
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _toWordLesson(context),
              );
              return const AppLoading();
            case GrammarStatus.playing:
              final cubit = context.read<GrammarLessonCubit>();
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spaceMd,
                  ),
                  child: Column(
                    children: [
                      GameTopBar(
                        hearts: state.hearts,
                        progress: state.progress,
                        heartsLeading: true,
                        onClose: () => context.pop(),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spaceMd,
                          ),
                          child: switch (state.step) {
                            null => const SizedBox.shrink(),
                            GrammarEquationCard card =>
                              GrammarEquationCardStep(
                                card: card,
                                audioUnavailable: state.audioUnavailable,
                                onSpeak: cubit.speak,
                              ),
                            GrammarTermsCard card =>
                              GrammarTermsCardStep(card: card),
                            GrammarChoiceStepData(:final choice) =>
                              GrammarChoiceStep(
                                choice: choice,
                                selectedId: state.selectedId,
                                onSelect: cubit.choose,
                              ),
                            GrammarStatementStepData data =>
                              GrammarStatementStep(
                                data: data,
                                answer: state.statementAnswer,
                                onAnswer: (v) =>
                                    cubit.answerStatement(answer: v),
                              ),
                            GrammarFillBlankStepData data =>
                              GrammarFillBlankStep(
                                data: data,
                                selectedId: state.selectedId,
                                onSelect: cubit.choose,
                              ),
                            GrammarCategoryStepData data =>
                              GrammarCategoryStep(
                                data: data,
                                selectedId: state.selectedId,
                                onSelect: cubit.choose,
                              ),
                            GrammarPictureStepData(:final question) =>
                              GrammarPictureStep(
                                question: question,
                                selectedId: state.selectedId,
                                audioUnavailable: state.audioUnavailable,
                                onPlay: () => cubit.speak(question.word),
                                onSelect: cubit.choose,
                              ),
                          },
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceMd),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spaceMd,
                        ),
                        child: QuizContinueButton(
                          enabled: state.isStepAnswered,
                          onPressed: cubit.continuePressed,
                        ),
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
