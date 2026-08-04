part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.reviewLinks = const [],
    this.friendLinks = const [],
    this.errorMessage,
  });

  final ProfileStatus status;
  final UserProfile? profile;
  final List<ProfileLink> reviewLinks;
  final List<ProfileLink> friendLinks;
  final String? errorMessage;

  ProfileState copyWith({
    ProfileStatus? status,
    UserProfile? profile,
    List<ProfileLink>? reviewLinks,
    List<ProfileLink>? friendLinks,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      reviewLinks: reviewLinks ?? this.reviewLinks,
      friendLinks: friendLinks ?? this.friendLinks,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    profile,
    reviewLinks,
    friendLinks,
    errorMessage,
  ];
}
