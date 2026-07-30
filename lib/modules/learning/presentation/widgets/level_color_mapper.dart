import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/level_type.dart';

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
}
