import '../../domain/entities/reward_card.dart';

class RewardCardModel extends RewardCard {
  const RewardCardModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.progress,
    required super.isLocked,
  });

  factory RewardCardModel.fromMap(Map<String, dynamic> map) {
    return RewardCardModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      progress: (map['progress'] ?? 0.0).toDouble(),
      isLocked: map['isLocked'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'progress': progress,
      'isLocked': isLocked,
    };
  }
}
