/// Central registry of asset paths. Real icons extracted from the
/// Let's Play design system (see assets/images/icons/).
class AppAssets {
  const AppAssets._();

  static const String _icons = 'assets/images/icons';

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

  // Onboarding / misc
  static const String paper = '$_icons/paper.png';
  static const String disc = '$_icons/disc.png';
  static const String magnifier = '$_icons/magnifier.png';
  static const String stairs = '$_icons/stairs.png';
  static const String timer = '$_icons/timer.png';
  static const String speaker = '$_icons/speaker.png';
  static const String contacts = '$_icons/contacts.png';
  static const String cardHeart = '$_icons/card_heart.png';

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
}
