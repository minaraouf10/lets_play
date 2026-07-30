import '../../domain/entities/lesson_entity.dart';

class LessonModel extends LessonEntity {
  const LessonModel({
    required super.id,
    required super.glyph,
    required super.transliteration,
    super.isUnlocked,
    super.isCompleted,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] as String,
      glyph: map['glyph'] as String,
      transliteration: map['transliteration'] as String,
      isUnlocked: map['isUnlocked'] as bool? ?? false,
      isCompleted: map['isCompleted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'glyph': glyph,
        'transliteration': transliteration,
        'isUnlocked': isUnlocked,
        'isCompleted': isCompleted,
      };
}
