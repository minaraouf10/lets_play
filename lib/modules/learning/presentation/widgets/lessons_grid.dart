import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../domain/entities/level_entity.dart';
import 'letter_tile.dart';
import 'level_color_mapper.dart';

class LessonsGrid extends StatelessWidget {
  const LessonsGrid({super.key, required this.level});

  final LevelEntity level;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: level.lessons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: AppDimensions.letterGridColumns,
        mainAxisSpacing: AppDimensions.letterGridSpacing,
        crossAxisSpacing: AppDimensions.letterGridSpacing,
      ),
      itemBuilder: (context, index) {
        final lesson = level.lessons[index];
        return LetterTile(
          lesson: lesson,
          accentColor: level.type.color,
          onTap: () {
            context.pushNamed(
              AppRoutes.letterGameName,
              queryParameters: {'lessonId': lesson.id},
            );
          },
        );
      },
    );
  }
}
