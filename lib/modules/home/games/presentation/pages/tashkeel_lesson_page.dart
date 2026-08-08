import '../../../../../core/utils/app_imports.dart';
import '../../../../../core/widgets/app_loading.dart';
import '../../data/datasources/letter_names_data.dart';
import '../cubit/tashkeel_lesson_cubit.dart';
import '../widgets/common/game_top_bar.dart';
import '../widgets/quiz/quiz_continue_button.dart';
import '../widgets/tashkeel/tashkeel_place_step.dart';
import '../widgets/tashkeel/tashkeel_quiz_step.dart';
import '../widgets/tashkeel/tashkeel_repeat_step.dart';
import '../widgets/tashkeel/tashkeel_review_step.dart';
import '../widgets/tashkeel/tashkeel_shape_match_step.dart';
import '../widgets/tashkeel/tashkeel_word_build_step.dart';
import '../widgets/tashkeel/tashkeel_word_repeat_step.dart';
import 'lesson_complete_page.dart';

/// The Level 2 (tashkeel) lesson shown after the brick puzzle: review each
/// carrier letter, quiz the pronunciation, listen and repeat, then place the
/// mark in the right spot.
class TashkeelLessonPage extends StatelessWidget {
  const TashkeelLessonPage({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TashkeelLessonCubit>()..load(lessonId),
      child: _TashkeelLessonView(lessonId: lessonId),
    );
  }
}

class _TashkeelLessonView extends StatelessWidget {
  const _TashkeelLessonView({required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<TashkeelLessonCubit, TashkeelLessonState>(
        builder: (context, state) {
          switch (state.status) {
            case TashkeelStatus.loading:
              return const AppLoading();
            case TashkeelStatus.error:
              return Center(child: Text(state.errorMessage ?? 'Error'));
            case TashkeelStatus.completed:
              return LessonCompletePage(
                userName: 'Malak',
                result: state.result,
                levelType: levelTypeForLessonId(lessonId),
              );
            case TashkeelStatus.ready:
              final cubit = context.read<TashkeelLessonCubit>();
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
                        child: SingleChildScrollView(
                          child: _StepBody(state: state, cubit: cubit),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceMd),
                      QuizContinueButton(
                        enabled: _canContinue(state),
                        onPressed: () => _onContinue(state, cubit),
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

  bool _canContinue(TashkeelLessonState state) => switch (state.step) {
        TashkeelStep.review => true,
        TashkeelStep.quiz => state.isQuizAnswerCorrect,
        TashkeelStep.repeat => state.hasRecorded,
        TashkeelStep.place => state.isPlacementCorrect,
        TashkeelStep.wordRepeat => state.wordHasRecorded,
        TashkeelStep.wordBuild => state.isWordBuildCorrect,
        TashkeelStep.shapeMatch => state.isShapeMatchCorrect,
      };

  void _onContinue(TashkeelLessonState state, TashkeelLessonCubit cubit) {
    switch (state.step) {
      case TashkeelStep.review:
        cubit.continueReview();
      case TashkeelStep.quiz:
        cubit.continueQuiz();
      case TashkeelStep.repeat:
        cubit.continueRepeat();
      case TashkeelStep.place:
        cubit.continuePlace();
      case TashkeelStep.wordRepeat:
        cubit.continueWordRepeat();
      case TashkeelStep.wordBuild:
        cubit.continueWordBuild();
      case TashkeelStep.shapeMatch:
        cubit.finish();
    }
  }
}

class _StepBody extends StatelessWidget {
  const _StepBody({required this.state, required this.cubit});

  final TashkeelLessonState state;
  final TashkeelLessonCubit cubit;

  /// The diacritic on its own, stripped of its carrier letter.
  static const String _fathaMark = 'َ';

  @override
  Widget build(BuildContext context) {
    final sample = state.currentSample;
    if (sample == null) return const SizedBox.shrink();

    switch (state.step) {
      case TashkeelStep.review:
        return TashkeelReviewStep(
          sample: sample,
          vowel: state.vowel,
          audioUnavailable: state.audioUnavailable,
          onPlay: cubit.playCurrent,
        );
      case TashkeelStep.quiz:
        return TashkeelQuizStep(
          sample: sample,
          options: state.syllableOptions,
          selectedSyllable: state.selectedSyllable,
          audioUnavailable: state.audioUnavailable,
          onPlay: cubit.playCurrent,
          onSelect: cubit.chooseSyllable,
        );
      case TashkeelStep.repeat:
        return TashkeelRepeatStep(
          isRecording: state.isRecording,
          hasRecorded: state.hasRecorded,
          audioUnavailable: state.audioUnavailable,
          onPlay: cubit.playCurrent,
          onPlaySlowly: cubit.playCurrentSlowly,
          onRecord: cubit.record,
        );
      case TashkeelStep.place:
        return TashkeelPlaceStep(
          markName: state.markName,
          carrierGlyph: sample.glyph.replaceAll(_fathaMark, ''),
          markGlyph: _fathaMark,
          selected: state.selectedPlacement,
          onSelect: cubit.choosePlacement,
        );
      case TashkeelStep.wordRepeat:
        final word = state.word;
        if (word == null) return const SizedBox.shrink();
        return TashkeelWordRepeatStep(
          word: word,
          isRecording: state.isRecording,
          hasRecorded: state.wordHasRecorded,
          audioUnavailable: state.audioUnavailable,
          onPlay: cubit.playWord,
          onPlaySlowly: cubit.playWordSlowly,
          onRecord: cubit.recordWord,
        );
      case TashkeelStep.wordBuild:
        final word = state.word;
        if (word == null) return const SizedBox.shrink();
        return TashkeelWordBuildStep(
          word: word,
          options: state.wordPieceOptions,
          droppedPiece: state.droppedPiece,
          isCorrect: state.isWordBuildCorrect,
          onPlay: cubit.playWord,
          onDrop: cubit.dropPiece,
        );
      case TashkeelStep.shapeMatch:
        return TashkeelShapeMatchStep(
          markNameArabic: spokenLetterFor(state.lessonId, state.markName),
          markGlyph: _fathaMark,
          selectedIsAbove: state.selectedShapeIsAbove,
          markSitsAbove: state.markSitsAbove,
          onPlay: cubit.playCurrent,
          onChoose: (isAbove) => cubit.chooseShape(isAbove: isAbove),
        );
    }
  }
}
