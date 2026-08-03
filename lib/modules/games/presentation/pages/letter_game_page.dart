import '../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/app_loading.dart';

import '../cubit/letter_game_cubit.dart';
import '../widgets/block_grid.dart';
import '../widgets/brick_palette.dart';
import '../widgets/game_result_overlay.dart';

/// "Build the letter" gameplay screen (Level 1 core mechanic).
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
      appBar: AppBar(
        backgroundColor: AppColors.levelLetters,
        title: const Text('Build the letter'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<LetterGameCubit, LetterGameState>(
        builder: (context, state) {
          switch (state.status) {
            case GameStatus.loading:
              return const AppLoading();
            case GameStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case GameStatus.playing:
            case GameStatus.completed:
              final puzzle = state.puzzle!;
              final cubit = context.read<LetterGameCubit>();
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppDimensions.spaceLg),
                    child: Column(
                      children: [
                        Text(
                          'Build:  ${puzzle.glyph}',
                          style: AppTextStyles.headingLarge,
                        ),
                        Text(
                          puzzle.transliteration,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        LinearProgressIndicator(
                          value: state.progress,
                          color: AppColors.levelLetters,
                          backgroundColor: AppColors.surface,
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                        Expanded(
                          child: Center(
                            child: BlockGrid(
                              puzzle: puzzle,
                              filled: state.filled,
                              brickColor:
                                  kBrickColors[state.selectedColor],
                              onTapCell: cubit.tapCell,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                        BrickPalette(
                          selectedIndex: state.selectedColor,
                          onSelected: cubit.selectColor,
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
                        },
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
