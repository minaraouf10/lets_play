import 'package:injectable/injectable.dart';

import '../../domain/entities/level_type.dart';
import '../models/lesson_model.dart';
import '../models/level_model.dart';

/// Offline-first source of truth for the MVP.
///
/// Per the brief, only a few sample lessons per level ship now
/// (L1=5, L2=3, L3=2, L4=4, L5=4). Adding the full content later is a
/// data change only — no architecture changes.
abstract class LearningLocalDataSource {
  Future<List<LevelModel>> getLevels();
}

@LazySingleton(as: LearningLocalDataSource)
class LearningLocalDataSourceImpl implements LearningLocalDataSource {
  @override
  Future<List<LevelModel>> getLevels() async {
    return _seedLevels;
  }

  static const List<LevelModel> _seedLevels = [
    LevelModel(
      type: LevelType.letters,
      titleEn: 'Level 1 (Letters)',
      titleAr: 'المستوى الأول (الحروف)',
      description:
          'Learn all the letters and their usage in words and unlock new worlds.',
      isUnlocked: true,
      lessons: [
        LessonModel(
            id: 'l1_alef',
            glyph: 'أ',
            transliteration: 'aa',
            isUnlocked: true),
        LessonModel(
            id: 'l1_ba', glyph: 'ب', transliteration: 'b', isUnlocked: true),
        LessonModel(id: 'l1_ta', glyph: 'ت', transliteration: 't'),
        LessonModel(id: 'l1_tha', glyph: 'ث', transliteration: 'th'),
        LessonModel(id: 'l1_jeem', glyph: 'ج', transliteration: 'j'),
      ],
    ),
    LevelModel(
      type: LevelType.tashkeel,
      titleEn: 'Level 2 (Tashkeel)',
      titleAr: 'المستوى الثاني (التشكيل)',
      description:
          'Learn all the tashkeel and their positions either over or below the baseline.',
      isUnlocked: true,
      lessons: [
        LessonModel(
            id: 'l2_fatha',
            glyph: 'كَ',
            transliteration: 'ka',
            isUnlocked: true),
        LessonModel(id: 'l2_kasra', glyph: 'كِ', transliteration: 'ki'),
        LessonModel(id: 'l2_damma', glyph: 'كُ', transliteration: 'ku'),
      ],
    ),
    LevelModel(
      type: LevelType.numbers,
      titleEn: 'Level 3 (Numbers)',
      titleAr: 'المستوى الثالث (الأرقام)',
      description:
          'Learn all the numbers and their usage and unlock new worlds.',
      isUnlocked: true,
      lessons: [
        LessonModel(
            id: 'l3_one', glyph: '١', transliteration: '1', isUnlocked: true),
        LessonModel(id: 'l3_two', glyph: '٢', transliteration: '2'),
      ],
    ),
    LevelModel(
      type: LevelType.words,
      titleEn: 'Level 4 (Words)',
      titleAr: 'المستوى الرابع (الكلمات)',
      description:
          'Learn all the words and their usage and unlock new worlds.',
      lessons: [
        LessonModel(
            id: 'l4_rajul', glyph: 'رجل', transliteration: '3 letter words'),
        LessonModel(
            id: 'l4_fi',
            glyph: 'في',
            transliteration: '2 letter words',
            isUnlocked: true),
        LessonModel(
            id: 'l4_jamad', glyph: 'جماد', transliteration: '4 letter words'),
        LessonModel(
            id: 'l4_hayawan',
            glyph: 'حيوان',
            transliteration: '5 letter words'),
      ],
    ),
    LevelModel(
      type: LevelType.sentences,
      titleEn: 'Level 5 (Sentences)',
      titleAr: 'المستوى الخامس (الجمل)',
      description:
          'Learn all the phrases and their usage and unlock new worlds.',
      lessons: [
        LessonModel(
            id: 'l5_directions',
            glyph: 'الاتجاهات',
            transliteration: 'Directions'),
        LessonModel(
            id: 'l5_intro',
            glyph: 'عرف نفسك',
            transliteration: 'Introduce Yourself',
            isUnlocked: true),
        LessonModel(
            id: 'l5_restaurants',
            glyph: 'مطاعم',
            transliteration: 'Restaurants'),
        LessonModel(
            id: 'l5_travel', glyph: 'السفر', transliteration: 'Travel'),
      ],
    ),
  ];
}
