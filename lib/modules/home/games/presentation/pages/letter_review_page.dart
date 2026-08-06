import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/app_loading.dart';
import '../../data/datasources/number_data.dart';
import '../cubit/letter_review_cubit.dart';
import '../widgets/letter_bricks_step.dart';
import '../widgets/letter_forms_step.dart';
import '../widgets/letter_glyph_step.dart';
import '../widgets/number_sound_step.dart';

/// Post-game "letter review" flow shown after [GreatJobPage]: the plain
/// glyph, then the assembled bricks, then the letter forms overview.
class LetterReviewPage extends StatelessWidget {
  const LetterReviewPage({
    super.key,
    required this.lessonId,
    required this.letterName,
  });

  final String lessonId;
  final String letterName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LetterReviewCubit>()..load(lessonId),
      child: _LetterReviewView(letterName: letterName),
    );
  }
}

class _LetterReviewView extends StatelessWidget {
  const _LetterReviewView({required this.letterName});

  final String letterName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LetterReviewCubit, LetterReviewState>(
        builder: (context, state) {
          switch (state.status) {
            case LetterReviewStatus.loading:
              return const AppLoading();
            case LetterReviewStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case LetterReviewStatus.ready:
              final puzzle = state.puzzle!;
              final cubit = context.read<LetterReviewCubit>();
              final number = numberLessonFor(puzzle.lessonId);
              // Numbers get a "Form the number" card before the trace round;
              // letters go straight into it as they always have.
              void toTrace() => context.pushReplacementNamed(
                    state.isNumber
                        ? AppRoutes.traceIntroName
                        : AppRoutes.letterTraceName,
                    queryParameters: {'lessonId': puzzle.lessonId},
                  );

              switch (state.step) {
                case LetterReviewStep.glyph:
                  return LetterGlyphStep(
                    letterName: letterName,
                    glyph: puzzle.glyph,
                    arabicWord: number?.wordAr,
                    onContinue: cubit.continuePressed,
                  );
                case LetterReviewStep.bricks:
                  return LetterBricksStep(
                    letterName: letterName,
                    puzzle: puzzle,
                    arabicWord: number?.wordAr,
                    onContinue: cubit.continuePressed,
                  );
                case LetterReviewStep.forms:
                  // Numbers have no positional forms — they close the review
                  // on the "listen and read" card instead.
                  if (state.isNumber && number != null) {
                    return NumberSoundStep(
                      puzzle: puzzle,
                      lesson: number,
                      hearts: 6,
                      progress: 1,
                      audioUnavailable: state.audioUnavailable,
                      onPlay: cubit.playSound,
                      onContinue: toTrace,
                    );
                  }
                  return LetterFormsStep(
                    letterName: letterName,
                    lessonId: puzzle.lessonId,
                    onContinue: toTrace,
                  );
              }
          }
        },
      ),
    );
  }
}
