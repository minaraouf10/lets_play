import '../../../../../core/utils/app_imports.dart';


/// Resolves the level a lesson belongs to from its id prefix ('l2_fatha' →
/// [LevelType.tashkeel]), so screens reached with only a lessonId can still
/// tint themselves. Falls back to [LevelType.letters] for unknown ids.
LevelType levelTypeForLessonId(String lessonId) {
  final match = RegExp(r'^l(\d+)_').firstMatch(lessonId);
  final index = int.tryParse(match?.group(1) ?? '');
  if (index == null || index < 1 || index > LevelType.values.length) {
    return LevelType.letters;
  }
  return LevelType.values[index - 1];
}

/// Keeps the domain UI-agnostic: colors are resolved only in presentation.
extension LevelTypeColor on LevelType {
  Color get color => switch (this) {
        LevelType.letters => AppColors.levelLetters,
        LevelType.tashkeel => AppColors.levelTashkeel,
        LevelType.numbers => AppColors.levelNumbers,
        LevelType.words => AppColors.levelWords,
        LevelType.sentences => AppColors.levelSentences,
      };

  /// Header text color for readability against the level color.
  Color get onColor => switch (this) {
        LevelType.letters => AppColors.textPrimary, // yellow needs dark text
        _ => AppColors.textOnColor,
      };

  /// 1-based position among the 5 levels (L1 Letters .. L5 Sentences).
  int get number => LevelType.values.indexOf(this) + 1;

  /// Character illustration on the level's "You'll learn" intro card.
  /// Levels without their own artwork reuse the generic lesson image.
  String get introImage => switch (this) {
        LevelType.numbers => AppAssets.levelThreeIntroImage,
        LevelType.words => AppAssets.levelFourIntroImage,
        _ => AppAssets.lessonImage,
      };

  /// Vertical tint-to-shade gradient used behind the lesson intro screens.
  Gradient get gradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.lerp(color, Colors.white, 0.45) ?? color, color],
      );

  /// Reverse of [gradient]: solid at the top fading pale toward the bottom.
  /// Used behind the celebration screen.
  Gradient get celebrationGradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color, Color.lerp(color, Colors.white, 0.6) ?? color],
      );
}
