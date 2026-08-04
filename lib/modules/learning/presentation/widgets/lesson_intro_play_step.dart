import '../../../../core/utils/app_imports.dart';

class LessonIntroPlayStep extends StatelessWidget {
  const LessonIntroPlayStep({
    super.key,
    required this.levelType,
    required this.lessonId,
  });

  final LevelType levelType;
  final String lessonId;

  bool get _isWordLesson => levelType == LevelType.words;

  String get _playRouteName =>
      _isWordLesson ? AppRoutes.wordLessonName : AppRoutes.letterGameName;

  String get _cardTitle => _isWordLesson ? 'Listen and repeat' : 'Tap on the blocks';

  String get _cardSubtitle => _isWordLesson ? 'To learn the word' : 'To form the letter';

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
