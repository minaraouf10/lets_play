import '../../../../core/utils/app_imports.dart';

import '../../domain/entities/level_entity.dart';
import 'letter_tile.dart';

/// Level 1-3 (letters/tashkeel/numbers) are short glyphs, shown as a dense
/// 5-column grid of square tiles. Level 4-5 (words/sentences) hold longer
/// text, so they get fewer, wider cards — see AppDimensions.wordGrid*.
class LessonsGrid extends StatelessWidget {
  const LessonsGrid({super.key, required this.level});

  final LevelEntity level;

  bool get _isWordStyle =>
      level.type == LevelType.words || level.type == LevelType.sentences;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: level.lessons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _isWordStyle
            ? AppDimensions.wordGridColumns
            : AppDimensions.letterGridColumns,
        mainAxisSpacing: AppDimensions.letterGridSpacing,
        crossAxisSpacing: AppDimensions.letterGridSpacing,
        childAspectRatio:
            _isWordStyle ? AppDimensions.wordGridAspectRatio : 1,
      ),
      itemBuilder: (context, index) {
        final lesson = level.lessons[index];
        return LetterTile(
          lesson: lesson,
          accentColor: level.type.color,
          onAccentColor: level.type.onColor,
          onTap: () {
            context.pushNamed(
              AppRoutes.lessonIntroName,
              queryParameters: {
                'lessonId': lesson.id,
                'levelType': level.type.name,
                'lessonNumber': '${index + 1}',
              },
            );
          },
        );
      },
    );
  }
}
