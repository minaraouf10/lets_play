import '../../../../core/utils/app_imports.dart';
import 'help_topic_tile.dart';

class HelpTopicsList extends StatelessWidget {
  const HelpTopicsList({
    super.key,
    required this.topics,
    required this.expandedId,
    required this.onToggle,
  });

  final List<HelpTopic> topics;
  final String? expandedId;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    if (topics.isEmpty) {
      return const Center(child: Text('No topics found'));
    }
    return ListView.separated(
      itemCount: topics.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final topic = topics[index];
        return HelpTopicTile(
          title: topic.title,
          body: topic.body ?? '',
          isExpanded: expandedId == topic.id,
          onToggle: () => onToggle(topic.id),
        );
      },
    );
  }
}
