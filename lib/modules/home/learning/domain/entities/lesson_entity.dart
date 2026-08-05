import 'package:equatable/equatable.dart';

/// A single learnable item inside a level.
/// For Level 1 this is a letter: [glyph] = 'ب', [transliteration] = 'b'.
class LessonEntity extends Equatable {
  const LessonEntity({
    required this.id,
    required this.glyph,
    required this.transliteration,
    this.isUnlocked = false,
    this.isCompleted = false,
  });

  final String id;
  final String glyph;
  final String transliteration;
  final bool isUnlocked;
  final bool isCompleted;

  @override
  List<Object?> get props =>
      [id, glyph, transliteration, isUnlocked, isCompleted];
}
