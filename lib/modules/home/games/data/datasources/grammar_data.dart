import '../../../../../core/constants/app_assets.dart';
import '../../domain/entities/grammar_lesson.dart';

/// Level 4 grammar content, keyed by lessonId.
///
/// This runs before the word lesson: the child learns what nouns and verbs
/// are, then conjugates verbs to match their subject. The lesson is an
/// ordered list of screens, so adding or reordering one is a data change
/// only — see [GrammarStepData].
final Map<String, GrammarLesson> kGrammarLessons = {
  'l4_fi': const GrammarLesson(
    lessonId: 'l4_fi',
    steps: [
      // ── Nouns ───────────────────────────────────────────────────────────
      GrammarEquationCard(
        heading: 'Choose the correct answer',
        title: 'انواع الكلمات',
        titleEn: '(Word Types)',
        rows: [
          GrammarEquation(
            example: GrammarTerm(id: 'ex_rajul', arabic: 'رجل', english: 'Man'),
            type: GrammarTerm(id: 'ty_ism', arabic: 'اسم', english: 'Name'),
            spoken: 'رجل اسم',
          ),
          GrammarEquation(
            example:
                GrammarTerm(id: 'ex_yasbah', arabic: 'يسبح', english: 'Swims'),
            type: GrammarTerm(id: 'ty_fil', arabic: 'فعل', english: 'Verb'),
            spoken: 'يسبح فعل',
          ),
          GrammarEquation(
            example: GrammarTerm(id: 'ex_fi', arabic: 'في', english: 'In'),
            type: GrammarTerm(id: 'ty_harf', arabic: 'حرف', english: 'Letter'),
            spoken: 'في حرف',
          ),
        ],
      ),
      GrammarChoiceStepData(
        GrammarChoice(
          prompt: 'Choose the Name\nin these words',
          options: [
            GrammarTerm(id: 'w_bayt', arabic: 'البيت', english: 'House'),
            GrammarTerm(id: 'w_mihfaza', arabic: 'محفظة', english: 'Wallet'),
            GrammarTerm(id: 'w_nusafir', arabic: 'نسافر', english: 'Travel'),
            GrammarTerm(id: 'w_taera', arabic: 'طائرة', english: 'Plane'),
            GrammarTerm(id: 'w_natbukh', arabic: 'نطبخ', english: 'Cook'),
            GrammarTerm(id: 'w_wa', arabic: 'و', english: 'And'),
          ],
          // "البيت" is the only concrete noun among the six.
          correctId: 'w_bayt',
        ),
      ),
      GrammarTermsCard(
        title: 'انواع الاسم',
        titleEn: '(Noun Types)',
        terms: [
          GrammarTerm(id: 'n_insan', arabic: 'إنسان', english: 'Human'),
          GrammarTerm(id: 'n_hayawan', arabic: 'حيوان', english: 'Animal'),
          GrammarTerm(id: 'n_jamad', arabic: 'جماد', english: 'Object'),
          GrammarTerm(id: 'n_makan', arabic: 'مكان', english: 'Place'),
          GrammarTerm(id: 'n_nabat', arabic: 'نبات', english: 'Plant'),
          GrammarTerm(id: 'n_sifa', arabic: 'صفة', english: 'Characteristic'),
        ],
      ),
      GrammarChoiceStepData(
        GrammarChoice(
          prompt: 'Choose the Noun',
          options: [
            GrammarTerm(id: 'c_katib', arabic: 'كاتب'),
            GrammarTerm(id: 'c_qaraa', arabic: 'قرأ'),
            GrammarTerm(id: 'c_laeb', arabic: 'لاعب'),
            GrammarTerm(id: 'c_qari', arabic: 'قارئ'),
          ],
          // "قرأ" is a past-tense verb; the other three are agent nouns.
          correctId: 'c_katib',
        ),
      ),
      GrammarPictureStepData(
        GrammarPictureQuestion(
          word: 'باب',
          // No door/house artwork ships yet — these stand in until the real
          // assets arrive, so the screen is playable rather than blank.
          options: [
            GrammarPictureOption(
              id: 'p_bab',
              asset: AppAssets.grammarDoorImage,
              label: 'Door',
            ),
            GrammarPictureOption(
              id: 'p_bayt',
              asset: AppAssets.grammarHouseImage,
              label: 'House',
            ),
          ],
          correctId: 'p_bab',
        ),
      ),

      // ── Noun signs ──────────────────────────────────────────────────────
      // The marks that identify a word as a noun: tanween, kasra, the tied
      // taa, and the definite article. Shown as bare tiles, no glosses.
      GrammarTermsCard(
        title: 'علامات تميز الاسم',
        titleEn: '(Noun Signs)',
        columns: 3,
        terms: [
          GrammarTerm(id: 's_tanween_fath', arabic: 'ـً'),
          GrammarTerm(id: 's_tanween_damm', arabic: 'ـٌ'),
          GrammarTerm(id: 's_tanween_kasr', arabic: 'ـٍ'),
          GrammarTerm(id: 's_ta_marbuta', arabic: 'ة'),
          GrammarTerm(id: 's_al', arabic: 'ال'),
        ],
      ),
      GrammarStatementStepData(
        heading: 'This word is a Noun',
        word: 'يعمل',
        // "يعمل" is a present-tense verb, so the claim is false.
        isTrue: false,
      ),

      // ── Verbs ───────────────────────────────────────────────────────────
      GrammarEquationCard(
        title: 'انواع الفعل',
        titleEn: '(Verb Types)',
        rows: [
          GrammarEquation(
            example:
                GrammarTerm(id: 'v_kharaja', arabic: 'خرج', english: 'Went out'),
            type: GrammarTerm(
              id: 'v_madi',
              arabic: 'الفعل الماضى',
              english: 'Past Tense',
            ),
          ),
          GrammarEquation(
            example:
                GrammarTerm(id: 'v_yakhruj', arabic: 'يخرج', english: 'Goes Out'),
            type: GrammarTerm(
              id: 'v_mudari',
              arabic: 'الفعل المضارع',
              english: 'Present Tense',
            ),
          ),
          GrammarEquation(
            example:
                GrammarTerm(id: 'v_ukhruj', arabic: 'اخرج', english: 'Go Out'),
            type: GrammarTerm(
              id: 'v_amr',
              arabic: 'الفعل الأمر',
              english: 'Imperative mood',
            ),
          ),
        ],
      ),
      GrammarEquationCard(
        title: 'الفعل الأمر',
        titleEn: '(Imperative Mood)',
        rows: [
          GrammarEquation(
            example:
                GrammarTerm(id: 'i_unzur', arabic: 'انظر', english: 'Look'),
            type: GrammarTerm(id: 'i_muzakkar', arabic: 'مذكر'),
            spoken: 'انظر',
          ),
          GrammarEquation(
            example:
                GrammarTerm(id: 'i_unzuri', arabic: 'انظري', english: 'Look'),
            type: GrammarTerm(id: 'i_muannath', arabic: 'مؤنث'),
            spoken: 'انظري',
          ),
        ],
      ),
      GrammarFillBlankStepData(
        before: 'أُمي',
        after: 'الطعام.',
        options: [
          GrammarTerm(id: 'f_tabakhat', arabic: 'طبخت'),
          GrammarTerm(id: 'f_tabakha', arabic: 'طبخ'),
        ],
        // "أُمي" is feminine, so the verb takes the feminine past ending.
        correctId: 'f_tabakhat',
      ),
      GrammarFillBlankStepData(
        before: 'أنا',
        after: 'لابني.',
        options: [
          GrammarTerm(id: 'f_zakartu', arabic: 'ذاكرتُ'),
          GrammarTerm(id: 'f_zakarta', arabic: 'ذاكرتَ'),
        ],
        // "أنا" takes the first-person ـتُ, not the second-person ـتَ.
        correctId: 'f_zakartu',
      ),
      GrammarFillBlankStepData(
        before: 'أخي',
        after: 'بالأمس.',
        options: [
          GrammarTerm(id: 'f_safara', arabic: 'سافر'),
          GrammarTerm(id: 'f_safarna', arabic: 'سافرنا'),
        ],
        // "أخي" is third-person singular, so no "we" ending.
        correctId: 'f_safara',
      ),
      GrammarEquationCard(
        title: 'علامات الفعل الماضي',
        titleEn: '(Past Tense Verb Signs)',
        rows: [
          GrammarEquation(
            example: GrammarTerm(
              id: 'p_ana',
              arabic: 'أنا خرجتُ',
              english: 'I Went out',
            ),
            type: GrammarTerm(id: 'p_tu', arabic: 'ـتُ'),
            spoken: 'أنا خرجتُ',
          ),
          GrammarEquation(
            example: GrammarTerm(
              id: 'p_nahnu',
              arabic: 'نحن خرجنا',
              english: 'We went out',
            ),
            type: GrammarTerm(id: 'p_na', arabic: 'ـنا'),
            spoken: 'نحن خرجنا',
          ),
          GrammarEquation(
            example: GrammarTerm(
              id: 'p_hiya',
              arabic: 'هي خرجتْ',
              english: 'She went out',
            ),
            type: GrammarTerm(id: 'p_t', arabic: 'ـتْ'),
            spoken: 'هي خرجتْ',
          ),
        ],
      ),
      GrammarFillBlankStepData(
        before: 'نحن',
        after: 'سيارة.',
        options: [
          GrammarTerm(id: 'f_nahtaj', arabic: 'نحتاج'),
          GrammarTerm(id: 'f_ahtaj', arabic: 'أحتاج'),
        ],
        // "نحن" takes the ن- prefix.
        correctId: 'f_nahtaj',
      ),
      GrammarFillBlankStepData(
        before: 'أنا',
        after: 'عن عمل.',
        options: [
          GrammarTerm(id: 'f_yabhath', arabic: 'يبحث'),
          GrammarTerm(id: 'f_abhath', arabic: 'أبحث'),
        ],
        // "أنا" takes the أ- prefix.
        correctId: 'f_abhath',
      ),
      GrammarFillBlankStepData(
        before: 'هي',
        after: 'الإنجليزية.',
        options: [
          GrammarTerm(id: 'f_tatahaddath', arabic: 'تتحدث'),
          GrammarTerm(id: 'f_natahaddath', arabic: 'نتحدث'),
        ],
        // "هي" takes the ت- prefix.
        correctId: 'f_tatahaddath',
      ),
      GrammarFillBlankStepData(
        before: 'هو',
        after: 'كرة السلة.',
        options: [
          GrammarTerm(id: 'f_yalab', arabic: 'يلعب'),
          GrammarTerm(id: 'f_alab', arabic: 'ألعب'),
        ],
        // "هو" takes the ي- prefix.
        correctId: 'f_yalab',
      ),

      // ── Wrap-up ─────────────────────────────────────────────────────────
      GrammarStatementStepData(
        heading: 'Imperative Mood',
        word: 'اكتب الرسالة',
        subtitle: '"Write the message"',
        // "اكتب" is a command, so the imperative label holds.
        isTrue: true,
      ),
      GrammarCategoryStepData(
        word: 'أكل',
        options: [
          GrammarTerm(id: 'k_mudari', arabic: 'مضارع'),
          GrammarTerm(id: 'k_madi', arabic: 'ماض'),
          GrammarTerm(id: 'k_amr', arabic: 'أمر'),
        ],
        // "أكل" is past tense.
        correctId: 'k_madi',
      ),
    ],
  ),
};

/// The grammar lesson for [lessonId], or null when the lesson has none and
/// should go straight to the word steps.
GrammarLesson? grammarLessonFor(String lessonId) => kGrammarLessons[lessonId];

/// True when [lessonId] opens with the grammar screens.
bool hasGrammarLesson(String lessonId) =>
    kGrammarLessons.containsKey(lessonId);
