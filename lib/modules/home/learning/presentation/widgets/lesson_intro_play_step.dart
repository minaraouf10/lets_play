import '../../../../../core/utils/app_imports.dart';

/// "Get ready to play" card shown before a brick round starts.
///
/// Used twice in a lesson: before the first (tap-to-place) round, and — with
/// [traceMode] set — before the trace round that follows the review.
class LessonIntroPlayStep extends StatelessWidget {
  const LessonIntroPlayStep({
    super.key,
    required this.levelType,
    required this.lessonId,
    this.traceMode = false,
  });

  final LevelType levelType;
  final String lessonId;

  /// When true the card introduces the trace round instead of the first one.
  final bool traceMode;

  bool get _isWordLesson => levelType == LevelType.words;

  String get _playRouteName => traceMode
      ? AppRoutes.letterTraceName
      : _isWordLesson
          ? AppRoutes.wordLessonName
          : AppRoutes.letterGameName;

  String get _subject => switch (levelType) {
        LevelType.words => 'word',
        LevelType.numbers => 'number',
        _ => 'letter',
      };

  String get _cardTitle {
    if (traceMode) return 'Form the $_subject';
    return _isWordLesson ? 'Listen and repeat' : 'Tap on the blocks';
  }

  /// What the bricks add up to: a word, a number (Level 3) or a letter.
  String get _cardSubtitle {
    if (traceMode) return 'Using the blocks';
    return _isWordLesson ? 'To learn the word' : 'To form the $_subject';
  }

  String get _image =>
      _isWordLesson ? AppAssets.fathersImage : AppAssets.tapOnTheBlocksImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: levelType.color,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.ink),
                  onPressed: () => context.pop(),
                ),
              ),
              Container(
                width: double.infinity,
                height: AppDimensions.onboardingCardMinH,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppDimensions.neoBorderWidth,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_cardTitle, style: AppTextStyles.cardTitle, textAlign: TextAlign.center),
                    Text(_cardSubtitle, style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
                  ],
                ),
              ),
              Expanded(
                child: _isWordLesson
                    ? SvgPicture.asset(_image, fit: BoxFit.contain)
                    : Image.asset(_image, fit: BoxFit.fitHeight),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              LessonIntroPlayButton(
                onPressed: () => context.pushReplacementNamed(
                  _playRouteName,
                  queryParameters: {'lessonId': lessonId},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
