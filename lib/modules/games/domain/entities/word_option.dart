import 'package:equatable/equatable.dart';

/// One selectable answer in a word-lesson exercise.
///
/// [imageAsset] is nullable because not every word has artwork yet (e.g.
/// "حصان" is audio/text only) — screens that need a picture must filter on
/// this field rather than assuming every option has one.
class WordOption extends Equatable {
  const WordOption({
    required this.id,
    required this.word,
    this.imageAsset,
  });

  final String id;
  final String word;
  final String? imageAsset;

  @override
  List<Object?> get props => [id, word, imageAsset];
}
