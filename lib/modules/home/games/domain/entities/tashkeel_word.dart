import 'package:equatable/equatable.dart';

/// A whole word that uses the lesson's mark, taught after the individual
/// carrier letters: heard and repeated, then rebuilt by dragging the missing
/// letter into place.
class TashkeelWord extends Equatable {
  const TashkeelWord({
    required this.word,
    required this.meaning,
    required this.illustration,
    required this.pieces,
    required this.missingIndex,
    required this.distractors,
  });

  /// The full word with its marks, e.g. "أَكَلَ".
  final String word;

  /// English gloss shown under the word, e.g. "Ate".
  final String meaning;

  /// Illustration shown beside the word on the drag step.
  final String illustration;

  /// The word split into its written pieces, right-to-left as displayed,
  /// e.g. ['أَ', 'كَ', 'لَ'].
  final List<String> pieces;

  /// Which entry of [pieces] is blanked out and must be dragged back in.
  final int missingIndex;

  /// Wrong pieces offered alongside the correct one.
  final List<String> distractors;

  /// The piece the player has to find.
  String get missingPiece => pieces[missingIndex];

  @override
  List<Object?> get props =>
      [word, meaning, illustration, pieces, missingIndex, distractors];
}
