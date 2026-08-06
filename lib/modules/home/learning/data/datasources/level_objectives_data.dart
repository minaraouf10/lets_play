import '../../domain/entities/level_type.dart';

/// The "You'll learn" bullets shown on the level intro card that opens a
/// lesson. Levels absent from this map simply skip that card, so adding one
/// for another level is a data change only.
const Map<LevelType, List<String>> kLevelObjectives = {
  LevelType.numbers: [
    'Forming the number',
    'Writing the number',
    'Pronunciation',
  ],
  LevelType.words: [
    'Forming words',
    'Writing words',
    'Pronunciation',
    'Dialogue',
  ],
};

List<String> objectivesFor(LevelType type) => kLevelObjectives[type] ?? const [];

/// Whether [type] has an objectives card to show before the lesson card.
bool hasObjectives(LevelType type) => objectivesFor(type).isNotEmpty;
