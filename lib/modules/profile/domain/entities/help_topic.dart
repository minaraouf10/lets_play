import 'package:equatable/equatable.dart';

class HelpTopic extends Equatable {
  const HelpTopic({
    required this.id,
    required this.title,
    this.body,
    required this.isInitiallyExpanded,
  });

  final String id;
  final String title;
  final String? body;
  final bool isInitiallyExpanded;

  @override
  List<Object?> get props => [id, title, body, isInitiallyExpanded];
}
