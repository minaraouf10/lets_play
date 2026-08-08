import 'package:injectable/injectable.dart';

import '../../domain/entities/level_type.dart';
import '../models/lesson_model.dart';
import '../models/level_model.dart';

/// Offline-first source of truth for the MVP.
///
/// Levels 1-3 list their full alphabet / mark set / number set so the grid
/// shows the whole curriculum. Only lessons with a puzzle behind them in
/// `games_local_datasource.dart` are unlocked; the rest render as greyed,
/// non-tappable tiles until their content is authored. Levels 4-5 still ship
/// a sample set. Adding content later is a data change only.
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
      // The 28 letters in alphabetical order, then lam-alef and the hamza
      // carriers the grid shows as its last row.
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
        LessonModel(id: 'l1_haa', glyph: 'ح', transliteration: 'H'),
        LessonModel(id: 'l1_khaa', glyph: 'خ', transliteration: 'kh'),
        LessonModel(id: 'l1_dal', glyph: 'د', transliteration: 'd'),
        LessonModel(id: 'l1_dhal', glyph: 'ذ', transliteration: 'dh'),
        LessonModel(id: 'l1_ra', glyph: 'ر', transliteration: 'r'),
        LessonModel(id: 'l1_zay', glyph: 'ز', transliteration: 'z'),
        LessonModel(id: 'l1_seen', glyph: 'س', transliteration: 's'),
        LessonModel(id: 'l1_sheen', glyph: 'ش', transliteration: 'sh'),
        LessonModel(id: 'l1_sad', glyph: 'ص', transliteration: 'S'),
        LessonModel(id: 'l1_dad', glyph: 'ض', transliteration: 'D'),
        LessonModel(id: 'l1_taa', glyph: 'ط', transliteration: 'T'),
        LessonModel(id: 'l1_dhaa', glyph: 'ظ', transliteration: 'DH'),
        LessonModel(id: 'l1_ayn', glyph: 'ع', transliteration: '3'),
        LessonModel(id: 'l1_ghayn', glyph: 'غ', transliteration: 'gh'),
        LessonModel(id: 'l1_fa', glyph: 'ف', transliteration: 'f'),
        LessonModel(id: 'l1_qaf', glyph: 'ق', transliteration: 'q'),
        LessonModel(id: 'l1_kaf', glyph: 'ك', transliteration: 'k'),
        LessonModel(id: 'l1_lam', glyph: 'ل', transliteration: 'L'),
        LessonModel(id: 'l1_meem', glyph: 'م', transliteration: 'm'),
        LessonModel(id: 'l1_noon', glyph: 'ن', transliteration: 'n'),
        LessonModel(id: 'l1_ha', glyph: 'ه', transliteration: 'h'),
        LessonModel(id: 'l1_waw', glyph: 'و', transliteration: 'w'),
        LessonModel(id: 'l1_ya', glyph: 'ي', transliteration: 'y'),
        // Lam-alef, written as one joined shape rather than two letters.
        LessonModel(id: 'l1_laa', glyph: 'لا', transliteration: 'Laa'),
        LessonModel(id: 'l1_lam_meem', glyph: 'لما', transliteration: 'l+m'),
        // The hamza and the letters that carry it.
        LessonModel(id: 'l1_hamza', glyph: 'ء', transliteration: '2'),
        LessonModel(id: 'l1_alef_hamza', glyph: 'أ', transliteration: '2'),
        LessonModel(id: 'l1_alef_bare', glyph: 'ا', transliteration: '2'),
        LessonModel(id: 'l1_waw_hamza', glyph: 'ؤ', transliteration: '2'),
        LessonModel(id: 'l1_ya_hamza', glyph: 'ئ', transliteration: '2'),
      ],
    ),
    LevelModel(
      type: LevelType.tashkeel,
      titleEn: 'Level 2 (Tashkeel)',
      titleAr: 'المستوى الثاني (التشكيل)',
      description:
          'Learn all the tashkeel and their positions either over or below the baseline.',
      isUnlocked: true,
      // Every mark is shown on a kaf carrier so the child compares the marks
      // themselves rather than the letters under them.
      lessons: [
        LessonModel(
            id: 'l2_fatha',
            glyph: 'كَ',
            transliteration: 'ka',
            isUnlocked: true),
        LessonModel(id: 'l2_kasra', glyph: 'كِ', transliteration: 'ki'),
        LessonModel(id: 'l2_damma', glyph: 'كُ', transliteration: 'ku'),
        LessonModel(id: 'l2_sukoon', glyph: 'كْ', transliteration: 'k'),
        LessonModel(id: 'l2_shadda', glyph: 'كّ', transliteration: 'kk'),
        // Tanween: the doubled marks that add a final "n".
        LessonModel(id: 'l2_fathatan', glyph: 'كً', transliteration: 'an'),
        LessonModel(id: 'l2_kasratan', glyph: 'كٍ', transliteration: 'in'),
        LessonModel(id: 'l2_dammatan', glyph: 'كٌ', transliteration: 'un'),
      ],
    ),
    LevelModel(
      type: LevelType.numbers,
      titleEn: 'Level 3 (Numbers)',
      titleAr: 'المستوى الثالث (الأرقام)',
      description:
          'Learn all the numbers and their usage and unlock new worlds.',
      isUnlocked: true,
      // Digits 1-10, then the hundreds and one thousand.
      lessons: [
        LessonModel(
            id: 'l3_one', glyph: '١', transliteration: '1', isUnlocked: true),
        LessonModel(id: 'l3_two', glyph: '٢', transliteration: '2'),
        LessonModel(id: 'l3_three', glyph: '٣', transliteration: '3'),
        LessonModel(id: 'l3_four', glyph: '٤', transliteration: '4'),
        LessonModel(id: 'l3_five', glyph: '٥', transliteration: '5'),
        LessonModel(id: 'l3_six', glyph: '٦', transliteration: '6'),
        LessonModel(id: 'l3_seven', glyph: '٧', transliteration: '7'),
        LessonModel(id: 'l3_eight', glyph: '٨', transliteration: '8'),
        LessonModel(id: 'l3_nine', glyph: '٩', transliteration: '9'),
        LessonModel(id: 'l3_ten', glyph: '١٠', transliteration: '10'),
        LessonModel(id: 'l3_hundred', glyph: '١٠٠', transliteration: '100'),
        LessonModel(
            id: 'l3_two_hundred', glyph: '٢٠٠', transliteration: '200'),
        LessonModel(
            id: 'l3_three_hundred', glyph: '٣٠٠', transliteration: '300'),
        LessonModel(
            id: 'l3_four_hundred', glyph: '٤٠٠', transliteration: '400'),
        LessonModel(
            id: 'l3_five_hundred', glyph: '٥٠٠', transliteration: '500'),
        LessonModel(
            id: 'l3_six_hundred', glyph: '٦٠٠', transliteration: '600'),
        LessonModel(
            id: 'l3_seven_hundred', glyph: '٧٠٠', transliteration: '700'),
        LessonModel(
            id: 'l3_eight_hundred', glyph: '٨٠٠', transliteration: '800'),
        LessonModel(
            id: 'l3_nine_hundred', glyph: '٩٠٠', transliteration: '900'),
        LessonModel(id: 'l3_thousand', glyph: '١٠٠٠', transliteration: '1000'),
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
