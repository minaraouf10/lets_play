import '../../domain/entities/profile_link.dart';
import '../../domain/entities/profile_link_kind.dart';

class ProfileLinkModel extends ProfileLink {
  const ProfileLinkModel({
    required super.kind,
    required super.label,
    required super.iconAsset,
    required super.isImplemented,
  });

  factory ProfileLinkModel.fromMap(Map<String, dynamic> map) {
    return ProfileLinkModel(
      kind: ProfileLinkKind.values.byName(map['kind'] as String),
      label: map['label'] as String,
      iconAsset: map['iconAsset'] as String,
      isImplemented: map['isImplemented'] as bool,
    );
  }
}
