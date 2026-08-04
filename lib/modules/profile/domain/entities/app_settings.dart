import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  const AppSettings({
    required this.displayName,
    required this.username,
    required this.password,
    required this.email,
    required this.soundEffects,
    required this.motivationalReminders,
    required this.friendRequests,
    required this.newsletterEmails,
  });

  final String displayName;
  final String username;
  final String password;
  final String email;
  final bool soundEffects;
  final bool motivationalReminders;
  final bool friendRequests;
  final bool newsletterEmails;

  AppSettings copyWith({
    String? displayName,
    String? username,
    String? password,
    String? email,
    bool? soundEffects,
    bool? motivationalReminders,
    bool? friendRequests,
    bool? newsletterEmails,
  }) {
    return AppSettings(
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      soundEffects: soundEffects ?? this.soundEffects,
      motivationalReminders: motivationalReminders ?? this.motivationalReminders,
      friendRequests: friendRequests ?? this.friendRequests,
      newsletterEmails: newsletterEmails ?? this.newsletterEmails,
    );
  }

  @override
  List<Object?> get props => [
    displayName,
    username,
    password,
    email,
    soundEffects,
    motivationalReminders,
    friendRequests,
    newsletterEmails,
  ];
}
