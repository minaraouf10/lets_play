/// Single source of truth for spacing, radii and sizes.
///
/// Rule for this project: **no hardcoded sizes** in widgets.
/// Always reference values from here so the UI stays consistent and
/// easy to re-theme for different screen densities.
class AppDimensions {
  const AppDimensions._();

  // Spacing scale (4pt grid).
  static const double spaceXs = 4;
  static const double spaceSm = 8;
  static const double spaceMd = 16;
  static const double spaceLg = 24;
  static const double spaceXl = 32;
  static const double spaceXxl = 48;

  // Border radii.
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 20;

  // Component sizes.
  static const double buttonHeight = 56;
  static const double inputHeight = 56;
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;

  // Learning grid.
  static const double letterTileSize = 64;
  static const double letterGridSpacing = 8;
  static const int letterGridColumns = 5;

  // Word/sentence grid (Level 4-5): fewer, wider cards than the letter grid.
  static const int wordGridColumns = 2;
  static const double wordGridAspectRatio = 2.0;

  // Neo-brutalist borders/shadows (level headers, letter tiles).
  static const double neoBorderWidth = 2;
  static const double neoBorderWidthSm = 2;
  static const double neoShadowOffset = 4;
  static const double neoShadowOffsetSm = 2;

  // HUD.
  static const double hudHeight = 48;

  // Bottom navigation (layout shell).
  static const double navBarHeight = 64;
  static const double navBarIconHeight = 28;
  static const double navBarBorderWidth = 1;
  static const double navBarTapRadius = 32;
  static const double navIconOpacityActive = 1;
  static const double navIconOpacityInactive = 0.45;

  // Learning HUD.
  static const double hudIconHeight = 24;
  static const double hudSettingsHeight = 29;

  // Onboarding & Auth.
  static const double progressBarHeight = 12;
  static const double onboardingCardMinH = 120;
  static const double optionRowHeight = 56;
  static const double socialIconSize = 28;
  static const double borderWidthSelected = 2;
  static const double borderWidth = 1;
  static const double onboardingGridSpacing = 12;
  static const double onboardingGridIconSize = 48;
  static const double onboardingGridChildAspectRatio = 1.05;

  // Splash.
  static const double splashLogoWidth = 103;
  static const double splashCanvasWidth = 375;

  // "Form the letter" game.
  static const double gameCellSize = 40;
  static const double gameCellGap = 2;
  static const double gameSnapTolerance = 34;
  static const double gameStudSize = 9;
  static const double gameStudInset = 5;
  static const double gameDotSpacing = 16;
  static const double gameDotRadius = 1;
  static const double gameProgressHeight = 14;
  static const double gameStageBrickWidth = 56;
  static const double gameStageBrickHeight = 28;
  static const double gameResetButtonSize = 48;
  static const int gameEnergyPerBrick = 50;
  static const int gameStartSeconds = 30;

  // Letter quiz screens.
  static const double quizSpeakerSize = 72;
  static const double quizSnailSize = 52;
  static const double quizOptionHeight = 170;
  static const double quizGlyphSize = 56;
  static const double quizStatementGlyphSize = 88;

  // Word lesson screens.
  static const double wordIllustrationHeight = 360;
  static const double wordGlyphSize = 44;
  static const double wordMicSize = 96;
  static const double wordMicIconSize = 44;
  static const double wordCardSpeakerSize = 36;
  static const double wordAudioCardHeight = 120;
  static const double wordImageCardHeight = 150;
  static const double wordBannerHeight = 110;
  static const double wordBannerTextSize = 40;
  static const int wordLessonStepCount = 4;
  static const int wordRecordingSeconds = 2;

  // Profile.
  static const double profileAvatarLg = 96;
  static const double profileAvatarMd = 48;
  static const double profileAvatarSm = 36;
  static const double profileEditBadge = 28;
  static const double followBoxHeight = 72;
  static const double statTileHeight = 84;
  static const double statTileIconSize = 24;
  static const double profileLinkRowHeight = 56;
  static const double profileGearSize = 28;

  // Settings.
  static const double settingsToggleRowHeight = 52;
  static const double settingsSectionGap = 24;
  static const double settingsPairSpacing = 12;

  // Feedback.
  static const double feedbackRowHeight = 44;
  static const double feedbackBodyMinHeight = 240;

  // Help center.
  static const double helpTileMinHeight = 52;
  static const double searchFieldHeight = 48;

  // Leaderboard.
  static const double podiumHeightFirst = 132;
  static const double podiumHeightSecond = 100;
  static const double podiumHeightThird = 80;
  static const double podiumBlockWidth = 92;
  static const double podiumAvatarSize = 56;
  static const double podiumCrownSize = 28;
  static const double segmentedHeight = 44;
  static const double leaderboardRowHeight = 64;
  static const double rankBadgeSize = 28;

  // Follower popup.
  static const double overlayCardWidth = 320;
  static const double overlayCloseSize = 24;
  static const double badgePillHeight = 30;

  // Achievements.
  static const double totalPointsFontSize = 44;
  static const double castleHeight = 240;
  static const double rewardsBannerHeight = 56;
  static const double rewardCardHeight = 180;
  static const double rewardProgressHeight = 8;
  static const double rewardPadlockSize = 32;
}
