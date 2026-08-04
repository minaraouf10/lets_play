import '../../domain/entities/help_topic.dart';

class HelpTopicModel extends HelpTopic {
  const HelpTopicModel({
    required super.id,
    required super.title,
    super.body,
    required super.isInitiallyExpanded,
  });

  factory HelpTopicModel.fromMap(Map<String, dynamic> map) {
    return HelpTopicModel(
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String?,
      isInitiallyExpanded: map['isInitiallyExpanded'] as bool? ?? false,
    );
  }
}
