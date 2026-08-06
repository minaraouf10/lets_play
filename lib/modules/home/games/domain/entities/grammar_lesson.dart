import 'package:equatable/equatable.dart';

/// One Arabic term paired with its English gloss, e.g. "اسم" / "Name".
///
/// Used for every labelled cell in the Level 4 grammar screens: the word-type
/// equations, the noun-type grid, and the answer tiles.
class GrammarTerm extends Equatable {
  const GrammarTerm({
    required this.id,
    required this.arabic,
    this.english,
  });

  final String id;
  final String arabic;

  /// Shown under [arabic] in parentheses. Null on screens that show the
  /// Arabic alone (e.g. "Choose the Noun").
  final String? english;

  @override
  List<Object?> get props => [id, arabic, english];
}

/// A row on an "X = Y" reference card, e.g. "رجل (Man) = اسم (Name)" or
/// "أنا خرجتُ = ـتُ".
class GrammarEquation extends Equatable {
  const GrammarEquation({
    required this.example,
    required this.type,
    this.spoken,
  });

  /// The example word, e.g. "رجل (Man)".
  final GrammarTerm example;

  /// The category it belongs to, e.g. "اسم (Name)".
  final GrammarTerm type;

  /// What this row's speaker button says. Null hides the button — only some
  /// cards give each row its own speaker.
  final String? spoken;

  @override
  List<Object?> get props => [example, type, spoken];
}

/// A "pick the right one" question: a prompt, a set of tiles, and the id of
/// the tile that is correct.
class GrammarChoice extends Equatable {
  const GrammarChoice({
    required this.prompt,
    required this.options,
    required this.correctId,
    this.columns = 2,
  });

  /// Heading above the tiles, e.g. "Choose the Name\nin these words".
  final String prompt;
  final List<GrammarTerm> options;
  final String correctId;

  /// How many tiles per row.
  final int columns;

  @override
  List<Object?> get props => [prompt, options, correctId, columns];
}

/// One screen of a grammar lesson.
///
/// The lesson is an ordered list of these rather than a fixed set of named
/// fields, so adding a screen — or reordering them — is a data change only.
sealed class GrammarStepData extends Equatable {
  const GrammarStepData();

  /// True when the screen asks nothing and CONTINUE is live immediately.
  bool get isReference => false;
}

/// A reference card: blue banner over "X = Y" rows, optionally with a
/// speaker per row. Used for word types, verb types, and the sign cards.
class GrammarEquationCard extends GrammarStepData {
  const GrammarEquationCard({
    required this.title,
    required this.titleEn,
    required this.rows,
    this.heading = 'Learn',
  });

  final String title;
  final String titleEn;
  final List<GrammarEquation> rows;

  /// Small line above the banner.
  final String heading;

  @override
  bool get isReference => true;

  @override
  List<Object?> get props => [title, titleEn, rows, heading];
}

/// A reference card whose body is a grid of terms rather than equations —
/// the noun types and the noun-sign tiles.
class GrammarTermsCard extends GrammarStepData {
  const GrammarTermsCard({
    required this.title,
    required this.titleEn,
    required this.terms,
    this.columns = 2,
    this.heading = 'Learn',
  });

  final String title;
  final String titleEn;
  final List<GrammarTerm> terms;
  final int columns;
  final String heading;

  @override
  bool get isReference => true;

  @override
  List<Object?> get props => [title, titleEn, terms, columns, heading];
}

/// "Pick the right word" — a prompt over a grid of tiles.
class GrammarChoiceStepData extends GrammarStepData {
  const GrammarChoiceStepData(this.choice);

  final GrammarChoice choice;

  @override
  List<Object?> get props => [choice];
}

/// A word on a coloured card with a claim about it — answer True or False.
class GrammarStatementStepData extends GrammarStepData {
  const GrammarStatementStepData({
    required this.heading,
    required this.word,
    required this.isTrue,
    this.subtitle,
  });

  /// The claim, e.g. "This word is a Noun" or "Imperative Mood".
  final String heading;

  /// The word being judged, e.g. "يعمل".
  final String word;

  /// Optional gloss under [word] on the card, e.g. "Write the message".
  final String? subtitle;

  /// Whether the claim actually holds.
  final bool isTrue;

  @override
  List<Object?> get props => [heading, word, subtitle, isTrue];
}

/// A word on a blue banner over wide category tiles: "is this verb past,
/// present or imperative?".
class GrammarCategoryStepData extends GrammarStepData {
  const GrammarCategoryStepData({
    required this.word,
    required this.options,
    required this.correctId,
    this.heading = 'Choose the correct verb',
  });

  /// The word being classified, e.g. "أكل".
  final String word;

  final List<GrammarTerm> options;
  final String correctId;
  final String heading;

  @override
  List<Object?> get props => [word, options, correctId, heading];
}

/// Fill in the blank: a sentence split around a gap, and two verbs to choose
/// between.
class GrammarFillBlankStepData extends GrammarStepData {
  const GrammarFillBlankStepData({
    required this.before,
    required this.after,
    required this.options,
    required this.correctId,
    this.heading = 'Choose the correct verb',
  });

  /// The sentence text before the blank, reading right-to-left, e.g. "أُمي".
  final String before;

  /// The text after the blank, e.g. "الطعام.".
  final String after;

  final List<GrammarTerm> options;
  final String correctId;
  final String heading;

  @override
  List<Object?> get props => [before, after, options, correctId, heading];
}

/// Hear a word, pick the picture that matches it.
class GrammarPictureStepData extends GrammarStepData {
  const GrammarPictureStepData(this.question);

  final GrammarPictureQuestion question;

  @override
  List<Object?> get props => [question];
}

/// The full Level 4 grammar bundle that runs before the word lesson.
class GrammarLesson extends Equatable {
  const GrammarLesson({required this.lessonId, required this.steps});

  final String lessonId;

  /// The screens, in the order they are shown.
  final List<GrammarStepData> steps;

  @override
  List<Object?> get props => [lessonId, steps];
}

/// A word on a blue banner, a speaker, and two picture tiles.
class GrammarPictureQuestion extends Equatable {
  const GrammarPictureQuestion({
    required this.word,
    required this.options,
    required this.correctId,
  });

  final String word;

  /// Each option must carry an [GrammarPictureOption.asset].
  final List<GrammarPictureOption> options;
  final String correctId;

  @override
  List<Object?> get props => [word, options, correctId];
}

class GrammarPictureOption extends Equatable {
  const GrammarPictureOption({
    required this.id,
    required this.asset,
    required this.label,
  });

  final String id;
  final String asset;

  /// What the picture shows, used as the tile's semantics label.
  final String label;

  @override
  List<Object?> get props => [id, asset, label];
}
