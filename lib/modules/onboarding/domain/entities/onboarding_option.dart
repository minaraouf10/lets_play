import 'package:equatable/equatable.dart';

class OnboardingOption extends Equatable {
  const OnboardingOption({
    required this.id,
    required this.label,
    this.subtitle,
    this.assetPath,
    this.trailingLabel,
  });

  final String id;
  final String label;
  final String? subtitle;
  final String? assetPath;
  final String? trailingLabel;

  @override
  List<Object?> get props => [id, label, subtitle, assetPath, trailingLabel];
}
