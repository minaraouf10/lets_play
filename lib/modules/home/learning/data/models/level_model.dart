import '../../domain/entities/level_entity.dart';
import '../../domain/entities/level_type.dart';
import 'lesson_model.dart';

class LevelModel extends LevelEntity {
  const LevelModel({
    required super.type,
    required super.titleEn,
    required super.titleAr,
    required super.description,
    required super.lessons,
    super.isUnlocked,
  });

  factory LevelModel.fromMap(Map<String, dynamic> map) {
    return LevelModel(
      type: LevelType.values.byName(map['type'] as String),
      titleEn: map['titleEn'] as String,
      titleAr: map['titleAr'] as String,
      description: map['description'] as String,
      isUnlocked: map['isUnlocked'] as bool? ?? false,
      lessons: (map['lessons'] as List<dynamic>)
          .map((e) => LessonModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
