import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/user_entity.dart';

/// Data-layer model. Converts Firebase [User] into a domain [UserEntity]
/// and (de)serialises for Firestore.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    super.displayName,
  });

  factory UserModel.fromFirebase(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'displayName': displayName,
      };
}
