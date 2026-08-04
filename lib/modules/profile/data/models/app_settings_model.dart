import '../../domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  const AppSettingsModel({
    required super.displayName,
    required super.username,
    required super.password,
    required super.email,
    required super.soundEffects,
    required super.motivationalReminders,
    required super.friendRequests,
    required super.newsletterEmails,
  });

  factory AppSettingsModel.fromEntity(AppSettings entity) {
    return AppSettingsModel(
      displayName: entity.displayName,
      username: entity.username,
      password: entity.password,
      email: entity.email,
      soundEffects: entity.soundEffects,
      motivationalReminders: entity.motivationalReminders,
      friendRequests: entity.friendRequests,
      newsletterEmails: entity.newsletterEmails,
    );
  }

  factory AppSettingsModel.fromMap(Map<String, dynamic> map) {
    return AppSettingsModel(
      displayName: map['displayName'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      soundEffects: map['soundEffects'] as bool? ?? true,
      motivationalReminders: map['motivationalReminders'] as bool? ?? true,
      friendRequests: map['friendRequests'] as bool? ?? true,
      newsletterEmails: map['newsletterEmails'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'username': username,
      'password': password,
      'email': email,
      'soundEffects': soundEffects,
      'motivationalReminders': motivationalReminders,
      'friendRequests': friendRequests,
      'newsletterEmails': newsletterEmails,
    };
  }
}
