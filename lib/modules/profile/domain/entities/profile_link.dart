import 'package:equatable/equatable.dart';

import 'profile_link_kind.dart';

class ProfileLink extends Equatable {
  const ProfileLink({
    required this.kind,
    required this.label,
    required this.iconAsset,
    required this.isImplemented,
  });

  final ProfileLinkKind kind;
  final String label;
  final String iconAsset;
  final bool isImplemented;

  @override
  List<Object?> get props => [kind, label, iconAsset, isImplemented];
}
