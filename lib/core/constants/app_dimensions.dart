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
}
