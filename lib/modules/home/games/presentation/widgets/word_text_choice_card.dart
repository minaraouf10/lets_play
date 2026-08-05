import '../../../../../core/utils/app_imports.dart';
import '../../domain/entities/word_option.dart';

/// Step 3's large text-only choice card.
class WordTextChoiceCard extends StatelessWidget {
  const WordTextChoiceCard({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  final WordOption option;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = !isSelected
        ? AppColors.border
        : isCorrect
            ? AppColors.success
            : AppColors.error;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.quizOptionHeight,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: borderColor,
            width: isSelected ? AppDimensions.neoBorderWidth : AppDimensions.borderWidth,
          ),
        ),
        child: Center(child: Text(option.word, style: AppTextStyles.wordGlyph)),
      ),
    );
  }
}
