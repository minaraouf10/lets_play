import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/app_loading.dart';
import '../../data/datasources/number_data.dart';
import '../cubit/letter_trace_cubit.dart';
import '../widgets/common/game_bottom_bar.dart';
import '../widgets/common/game_result_overlay.dart';
import '../widgets/common/game_stage_bricks.dart';
import '../widgets/common/game_top_bar.dart';
import '../widgets/puzzle/trace_canvas.dart';

/// "Trace the letter" mode: the letter is shown as empty outlined cells and
/// the player drags across them to draw it in bricks.
class LetterTracePage extends StatelessWidget {
  const LetterTracePage({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LetterTraceCubit>()..load(lessonId),
      child: const _LetterTraceView(),
    );
  }
}

class _LetterTraceView extends StatelessWidget {
  const _LetterTraceView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gameCanvas,
      body: BlocBuilder<LetterTraceCubit, LetterTraceState>(
        builder: (context, state) {
          switch (state.status) {
            case TraceStatus.loading:
              return const AppLoading();
            case TraceStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case TraceStatus.tracing:
            case TraceStatus.completed:
            case TraceStatus.failed:
              final puzzle = state.puzzle!;
              final cubit = context.read<LetterTraceCubit>();
              return Stack(
                children: [
                  SafeArea(
                    child: Column(
                      children: [
                        GameTopBar(
                          hearts: state.hearts,
                          progress: state.progress,
                          onClose: () => context.pop(),
                        ),
                        const SizedBox(height: AppDimensions.spaceSm),
                        GameStageBricks(lessonId: puzzle.lessonId),
                        const SizedBox(height: AppDimensions.spaceMd),
                        Expanded(
                          child: TraceCanvas(
                            puzzle: puzzle,
                            filledCells: state.filledCells,
                            onTouchCell: cubit.touchCell,
                          ),
                        ),
                        GameBottomBar(
                          secondsLeft: state.secondsLeft,
                          energy: state.energy,
                          onReset: cubit.reset,
                        ),
                      ],
                    ),
                  ),
                  if (state.status == TraceStatus.completed)
                    GameResultOverlay(
                      glyph: puzzle.glyph,
                      transliteration: puzzle.transliteration,
                      stars: state.stars,
                      onReplay: cubit.reset,
                      onDone: () => context.pushReplacementNamed(
                        AppRoutes.greatJobName,
                        queryParameters: {
                          'lessonId': puzzle.lessonId,
                          'userName': 'Malak',
                          'levelType':
                              levelTypeForLessonId(puzzle.lessonId).name,
                          // Numbers get their own six-question quiz.
                          'nextRoute': isNumberLesson(puzzle.lessonId)
                              ? AppRoutes.numberQuizName
                              : AppRoutes.letterQuizName,
                        },
                      ),
                    ),
                  if (state.status == TraceStatus.failed)
                    _TimeUpOverlay(onRetry: cubit.reset),
                ],
              );
          }
        },
      ),
    );
  }
}

class _TimeUpOverlay extends StatelessWidget {
  const _TimeUpOverlay({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(AppDimensions.spaceLg),
          padding: const EdgeInsets.all(AppDimensions.spaceLg),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Time's up!", style: AppTextStyles.headingMedium),
              const SizedBox(height: AppDimensions.spaceMd),
              AppButton(
                label: 'Try again',
                color: AppColors.primary,
                onPressed: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
