import '../../../../core/utils/app_imports.dart';


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

  /// Vertical tint-to-shade gradient used behind the lesson intro screens.
  Gradient get gradient => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.lerp(color, Colors.white, 0.45) ?? color, color],
      );
}
