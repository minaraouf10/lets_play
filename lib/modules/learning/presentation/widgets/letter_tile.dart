import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/lesson_entity.dart';

/// One cell in the letter/lesson grid. Locked lessons are dimmed.
class LetterTile extends StatelessWidget {
  const LetterTile({
    super.key,
    required this.lesson,
    required this.accentColor,
    this.onTap,
  });

  final LessonEntity lesson;
  final Color accentColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final unlocked = lesson.isUnlocked;
    return Opacity(
      opacity: unlocked ? 1 : 0.4,
      child: InkWell(
        onTap: unlocked ? onTap : null,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        child: Container(
          decoration: BoxDecoration(
            color: unlocked ? accentColor.withValues(alpha: 0.15) : AppColors.surface,
            border: Border.all(
              color: unlocked ? accentColor : AppColors.border,
              width: unlocked ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(lesson.glyph, style: AppTextStyles.letterGlyph),
              Text(lesson.transliteration, style: AppTextStyles.letterHint),
            ],
          ),
        ),
      ),
    );
  }
}
