import '../../../../core/utils/app_imports.dart';

import 'lessons_grid.dart';
import 'level_header.dart';

class LevelsList extends StatelessWidget {
  const LevelsList({super.key, required this.levels});

  final List<LevelEntity> levels;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppDimensions.spaceMd),
      itemCount: levels.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppDimensions.spaceLg),
      itemBuilder: (context, index) {
        final level = levels[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LevelHeader(level: level),
            const SizedBox(height: AppDimensions.spaceMd),
            LessonsGrid(level: level),
          ],
        );
      },
    );
  }
}
