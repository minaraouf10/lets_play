import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/app_loading.dart';
import '../../data/datasources/tashkeel_data.dart';
import '../cubit/letter_game_cubit.dart';
import '../widgets/common/game_bottom_bar.dart';
import '../widgets/common/game_result_overlay.dart';
import '../widgets/common/game_stage_bricks.dart';
import '../widgets/common/game_top_bar.dart';
import '../widgets/puzzle/puzzle_canvas.dart';

class LetterGamePage extends StatelessWidget {
  const LetterGamePage({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LetterGameCubit>()..load(lessonId),
      child: const _LetterGameView(),
    );
  }
}

class _LetterGameView extends StatelessWidget {
  const _LetterGameView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gameCanvas,
      body: BlocBuilder<LetterGameCubit, LetterGameState>(
        builder: (context, state) {
          switch (state.status) {
            case GameStatus.loading:
              return const AppLoading();
            case GameStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case GameStatus.playing:
            case GameStatus.completed:
            case GameStatus.failed:
              final puzzle = state.puzzle!;
              final cubit = context.read<LetterGameCubit>();
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
                          child: PuzzleCanvas(puzzle: puzzle, state: state),
                        ),
                        GameBottomBar(
                          secondsLeft: state.secondsLeft,
                          energy: state.energy,
                          onReset: cubit.reset,
                        ),
                      ],
                    ),
                  ),
                  if (state.status == GameStatus.completed)
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
                          // Tashkeel marks have no positional forms, so they
                          // skip the letter review and go to their own flow.
                          if (isTashkeelLesson(puzzle.lessonId))
                            'nextRoute': AppRoutes.tashkeelLessonName,
                        },
                      ),
                    ),
                  if (state.status == GameStatus.failed)
                    ColoredBox(
                      color: Colors.black54,
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.all(AppDimensions.spaceLg),
                          padding: const EdgeInsets.all(AppDimensions.spaceLg),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusLg),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Time's up!",
                                  style: AppTextStyles.headingMedium),
                              const SizedBox(height: AppDimensions.spaceMd),
                              AppButton(
                                label: 'Try again',
                                color: AppColors.primary,
                                onPressed: cubit.reset,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
          }
        },
      ),
    );
  }
}
