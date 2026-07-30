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
}
