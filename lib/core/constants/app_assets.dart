/// Central registry of asset paths. Real icons extracted from the
/// Let's Play design system (see assets/images/icons/).
class AppAssets {
  const AppAssets._();

  static const String _icons = 'assets/images/icons';

  // HUD
  static const String coin = '$_icons/sparkle.png'; // yellow star = coins/stars
  static const String heart = '$_icons/heart.png';
  static const String energy = '$_icons/bolt.png';
  static const String settings = '$_icons/gear.png';

  // Bottom navigation
  static const String home = '$_icons/home.png';
  static const String sparkle = '$_icons/sparkle.png';
  static const String crown = '$_icons/crown.png';
  static const String smiley = '$_icons/smiley.png';

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
  static const List<String> splashFrames = [
    'assets/images/splash/lego_splash_1.svg',
    'assets/images/splash/lego_splash_2.svg',
    'assets/images/splash/lego_splash_3.svg',
    'assets/images/splash/lego_splash_4.svg',
  ];
  static const String splashLogo = 'assets/images/splash/lego_splash_logo.svg';

  // Onboarding — "why study Arabic?" reason icons.
  static const String _introIcons = 'assets/images/intrto_icons';
  static const String reasonFutureTrips = '$_introIcons/future_trips_icons.svg';
  static const String reasonConnections = '$_introIcons/connections_icons.svg';
  static const String reasonEducational = '$_introIcons/educational_icons.svg';
  static const String reasonCareer = '$_introIcons/career_icons.svg';
  static const String reasonOther = '$_introIcons/Other_icon.svg';
}
