part of 'help_center_cubit.dart';

enum HelpCenterStatus { initial, loading, loaded, error }

class HelpCenterState extends Equatable {
  const HelpCenterState({
    this.status = HelpCenterStatus.initial,
    this.topics = const [],
    this.query = '',
    this.expandedId,
    this.errorMessage,
  });

  final HelpCenterStatus status;
  final List<HelpTopic> topics;
  final String query;
  final String? expandedId;
  final String? errorMessage;

  /// Filter topics by query (case-insensitive title/body contains).
  List<HelpTopic> get visibleTopics {
    if (query.isEmpty) return topics;
    final lowerQuery = query.toLowerCase();
    return topics
        .where((t) =>
            t.title.toLowerCase().contains(lowerQuery) ||
            (t.body?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }

  HelpCenterState copyWith({
    HelpCenterStatus? status,
    List<HelpTopic>? topics,
    String? query,
    String? expandedId,
    String? errorMessage,
  }) {
    return HelpCenterState(
      status: status ?? this.status,
      topics: topics ?? this.topics,
      query: query ?? this.query,
      expandedId: expandedId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    topics,
    query,
    expandedId,
    errorMessage,
  ];
}
