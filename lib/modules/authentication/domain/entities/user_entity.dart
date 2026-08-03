
import '../../../../core/utils/app_imports.dart';

/// Pure domain user. No Firebase types leak into the domain layer.
class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
  });

  final String id;
  final String email;
  final String? displayName;

  @override
  List<Object?> get props => [id, email, displayName];
}
