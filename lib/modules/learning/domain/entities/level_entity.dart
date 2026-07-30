import 'package:equatable/equatable.dart';

import 'lesson_entity.dart';
import 'level_type.dart';

/// A level groups a set of lessons. The MVP ships only a few sample
/// lessons per level; the structure scales to the full 300-screen content
/// without code changes (just more data).
class LevelEntity extends Equatable {
  const LevelEntity({
    required this.type,
    required this.titleEn,
    required this.titleAr,
    required this.description,
    required this.lessons,
    this.isUnlocked = false,
  });

  final LevelType type;
  final String titleEn;
  final String titleAr;
  final String description;
  final List<LessonEntity> lessons;
  final bool isUnlocked;

  @override
  List<Object?> get props =>
      [type, titleEn, titleAr, description, lessons, isUnlocked];
}
