import 'package:equatable/equatable.dart';

class RewardCard extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final double progress;
  final bool isLocked;

  const RewardCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.isLocked,
  });

  @override
  List<Object?> get props => [id, title, subtitle, progress, isLocked];
}
