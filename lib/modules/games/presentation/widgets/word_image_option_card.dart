import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/word_option.dart';

/// Step 4's image choice card. [WordOption.imageAsset] must be non-null —
/// [WordLesson]'s constructor asserts this for every image-step option.
class WordImageOptionCard extends StatelessWidget {
  const WordImageOptionCard({
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
        height: AppDimensions.wordImageCardHeight,
        padding: const EdgeInsets.all(AppDimensions.spaceMd),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          border: Border.all(
            color: borderColor,
            width: isSelected ? AppDimensions.neoBorderWidth : AppDimensions.borderWidth,
          ),
        ),
        child: SvgPicture.asset(option.imageAsset!, fit: BoxFit.contain),
      ),
    );
  }
}
