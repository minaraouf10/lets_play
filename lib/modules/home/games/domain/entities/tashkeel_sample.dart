import 'package:equatable/equatable.dart';

/// One carrier letter shown with the lesson's diacritic applied, e.g. "كَ".
///
/// A tashkeel lesson walks through several of these so the child sees the same
/// mark on different letters and learns it as a mark rather than as part of one
/// specific letter.
class TashkeelSample extends Equatable {
  const TashkeelSample({
    required this.glyph,
    required this.carrierName,
    required this.syllable,
    required this.spoken,
  });

  /// The carrier letter with the diacritic applied, e.g. "كَ".
  final String glyph;

  /// Latin name of the carrier letter alone, e.g. "KAF".
  final String carrierName;

  /// How the combination is read, e.g. "Ka".
  final String syllable;

  /// What text-to-speech should pronounce for this sample.
  final String spoken;

  /// The formula line shown on the review card, e.g. "KAF+a= Ka".
  String equationFor(String markVowel) => '$carrierName+$markVowel= $syllable';

  @override
  List<Object?> get props => [glyph, carrierName, syllable, spoken];
}
