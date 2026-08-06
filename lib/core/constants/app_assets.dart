/// Central registry of asset paths. Real icons extracted from the
/// Let's Play design system (see assets/images/icons/).
class AppAssets {
  const AppAssets._();

  // Quiz icons.
  static const String _icons = 'assets/images/icons';
  static const String speakerIcon = '$_icons/speaker_icon.svg';
  static const String snailIcon = '$_icons/snail_icon.svg';
  static const String microphoneIcon = '$_icons/microphone_icon.svg';

  // Bottom navigation (layout shell) — full-color SVGs.
  static const String _layoutIcons = 'assets/images/layout_icons';
  static const String navHome = '$_layoutIcons/home_layout_icon.svg';
  static const String navStar = '$_layoutIcons/star_layout_icon.svg';
  static const String navCrown = '$_layoutIcons/crown_layout_icon.svg';
  static const String navEmoji = '$_layoutIcons/emoji_layout_icon.svg';

  // Learning HUD — SVGs.
  static const String _homeIcons = 'assets/images/home';
  static const String hudHeart = '$_homeIcons/heart_icon.svg';
  static const String hudEnergy = '$_homeIcons/voltage_icon.svg';
  static const String hudSettings = '$_homeIcons/setting_icon.svg';

  /// No coin icon exists under assets/images/home — the HUD deliberately
  /// reuses the bottom-nav star.
  static const String hudCoin = navStar;

  // Lesson intro flow.
  static const String lessonImage = '$_homeIcons/lesson_image.svg';
  static const String tapOnTheBlocksImage =
      '$_homeIcons/tap_on_the_blocks.png';
  static const String greatJobCharacter =
      '$_homeIcons/great_job_image.png';

  // Level 4 (Words) grammar flow — "pick the picture" question.
  //
  // No door/house artwork ships yet, so these point at the closest existing
  // intro icons. Swap the paths once the real assets land; nothing else
  // needs to change.
  static const String grammarDoorImage = reasonFutureTrips;
  static const String grammarHouseImage = reasonConnections;

  // Level 3 (Numbers) lesson flow.
  static const String _level3 = 'assets/images/level3';
  static const String levelThreeIntroImage = '$_level3/image_level_3.svg';

  /// Level 4's own intro artwork has not been supplied yet, so the level
  /// card falls back to the generic lesson illustration. Point this at the
  /// real file once it lands.
  static const String levelFourIntroImage = lessonImage;

  // Word lesson flow.
  static const String fathersImage = '$_homeIcons/fathers_image.svg';
  static const String lionImage = '$_homeIcons/lion_image.svg';

  // Onboarding / misc
  // static const String paper = '$_icons/paper.png';
  // static const String disc = '$_icons/disc.png';
  // static const String magnifier = '$_icons/magnifier.png';
  // static const String stairs = '$_icons/stairs.png';
  // static const String timer = '$_icons/timer.png';
  // static const String speaker = '$_icons/speaker.png';
  // static const String contacts = '$_icons/contacts.png';
  // static const String cardHeart = '$_icons/card_heart.png';

  // Splash
  static const String splashGif = 'assets/images/splash/splash.gif';
  static const String splashLogo = 'assets/images/splash/lego_splash_logo.svg';

  // Onboarding — "why study Arabic?" reason icons.
  static const String _introIcons = 'assets/images/intrto_icons';
  static const String reasonFutureTrips = '$_introIcons/future_trips_icons.svg';
  static const String reasonConnections = '$_introIcons/connections_icons.svg';
  static const String reasonEducational = '$_introIcons/educational_icons.svg';
  static const String reasonCareer = '$_introIcons/career_icons.svg';
  static const String reasonOther = '$_introIcons/Other_icon.svg';

  // Profile tab.
  static const String _profile = 'assets/images/profile';
  static const String profileAvatar = '$_profile/profile.png';
  static const String profileUserAvatar = '$_profile/user1_icon.png';
  static const String profileMistakes = '$_profile/mistakes_icon.svg';
  static const String profileQuiz = '$_profile/quiz_icon.svg';
  static const String profileFacebook = '$_profile/facebook_icon.svg';
  static const String profileInstagram = '$_profile/instgram_icon.svg';
  static const String profileInviteFriends = '$_profile/invite_friends_icon.svg';
  static const String profileContacts = '$_profile/contacts_icon.svg';
  static const String profileSendMessage = '$_profile/send_message_icon.svg';
  static const String pointsIcon = '$_profile/points_icon.svg';

  // Achievements.
  static const String achievementsCastle = '$_homeIcons/castle_illustration.svg';

  // Leaderboard.
  static const String podiumRankImage = 'assets/images/leaderboard/rank_image.png';
}
