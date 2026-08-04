import '../models/profile_link_model.dart';
import '../models/user_profile_model.dart';
import '../models/user_stat_model.dart';
import '../../domain/entities/profile_link_kind.dart';
import '../../domain/entities/stat_kind.dart';

class ProfileSeedData {
  static const UserProfileModel seedProfile = UserProfileModel(
    id: 'user_malak',
    displayName: 'Malak',
    avatarAsset: 'assets/images/profile/profile.png',
    joinedLabel: 'Joined February 2023',
    followingCount: 60,
    followersCount: 150,
    stats: [
      UserStatModel(kind: StatKind.energy, value: 15),
      UserStatModel(kind: StatKind.hearts, value: 6),
      UserStatModel(kind: StatKind.points, value: 300),
    ],
  );

  static const List<ProfileLinkModel> seedReviewLinks = [
    ProfileLinkModel(
      kind: ProfileLinkKind.mistakes,
      label: 'My Mistakes',
      iconAsset: 'assets/images/profile/mistakes_icon.svg',
      isImplemented: false,
    ),
    ProfileLinkModel(
      kind: ProfileLinkKind.quickQuiz,
      label: 'Quick Quiz',
      iconAsset: 'assets/images/profile/quiz_icon.svg',
      isImplemented: false,
    ),
  ];

  static const List<ProfileLinkModel> seedFriendLinks = [
    ProfileLinkModel(
      kind: ProfileLinkKind.facebook,
      label: 'Facebook',
      iconAsset: 'assets/images/profile/facebook_icon.svg',
      isImplemented: false,
    ),
    ProfileLinkModel(
      kind: ProfileLinkKind.instagram,
      label: 'Instagram',
      iconAsset: 'assets/images/profile/instgram_icon.svg',
      isImplemented: false,
    ),
    ProfileLinkModel(
      kind: ProfileLinkKind.inviteFriends,
      label: 'Invite Friends',
      iconAsset: 'assets/images/profile/invite_friends_icon.svg',
      isImplemented: false,
    ),
    ProfileLinkModel(
      kind: ProfileLinkKind.contacts,
      label: 'Contacts',
      iconAsset: 'assets/images/profile/contacts_icon.svg',
      isImplemented: false,
    ),
  ];
}
