import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/app_loading.dart';
import '../cubit/word_lesson_cubit.dart';
import '../widgets/game_top_bar.dart';
import '../widgets/quiz_continue_button.dart';
import '../widgets/word_audio_options_step.dart';
import '../widgets/word_image_choice_step.dart';
import '../widgets/word_repeat_step.dart';
import '../widgets/word_text_choice_step.dart';

/// The 4-step word lesson: hear it, pick it by sound, pick it by text,
/// pick it by picture.
class WordLessonPage extends StatelessWidget {
  const WordLessonPage({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WordLessonCubit>()..load(lessonId),
      child: _WordLessonView(lessonId: lessonId),
    );
  }
}

class _WordLessonView extends StatelessWidget {
  const _WordLessonView({required this.lessonId});

  final String lessonId;

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
      body: BlocBuilder<WordLessonCubit, WordLessonState>(
        builder: (context, state) {
          switch (state.status) {
            case WordLessonStatus.loading:
              return const AppLoading();
            case WordLessonStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case WordLessonStatus.completed:
              WidgetsBinding.instance.addPostFrameCallback((_) => _finish(context));
              return const AppLoading();
            case WordLessonStatus.repeat:
            case WordLessonStatus.chooseAudio:
            case WordLessonStatus.chooseText:
            case WordLessonStatus.chooseImage:
              final cubit = context.read<WordLessonCubit>();
              final lesson = state.lesson!;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceMd),
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
                          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
                          child: switch (state.status) {
                            WordLessonStatus.repeat => WordRepeatStep(
                                lesson: lesson,
                                isRecording: state.isRecording,
                                hasRecorded: state.hasRecorded,
                                audioUnavailable: state.audioUnavailable,
                                onPlay: cubit.playTargetWord,
                                onRecord: cubit.startRecording,
                              ),
                            WordLessonStatus.chooseAudio => WordAudioOptionsStep(
                                lesson: lesson,
                                selectedOptionId: state.selectedAudioOptionId,
                                onPlay: cubit.playOption,
                                onSelect: cubit.chooseAudioOption,
                              ),
                            WordLessonStatus.chooseText => WordTextChoiceStep(
                                lesson: lesson,
                                selectedOptionId: state.selectedTextOptionId,
                                audioUnavailable: state.audioUnavailable,
                                onPlay: cubit.playTargetWord,
                                onPlaySlowly: cubit.playTargetSlowly,
                                onSelect: cubit.chooseTextOption,
                              ),
                            WordLessonStatus.chooseImage => WordImageChoiceStep(
                                lesson: lesson,
                                selectedOptionId: state.selectedImageOptionId,
                                onPlay: cubit.playImagePrompt,
                                onSelect: cubit.chooseImageOption,
                              ),
                            _ => const SizedBox.shrink(),
                          },
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceMd),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
                        child: QuizContinueButton(
                          enabled: state.canContinue,
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
