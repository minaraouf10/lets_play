
import '../utils/app_imports.dart';

/// Brand + semantic colors.
///
/// The 5 learning levels each own a color (from the design):
/// L1 Letters = yellow, L2 Tashkeel = orange, L3 Numbers = blue,
/// L4 Words = green, L5 Sentences = purple.
class AppColors {
  const AppColors._();

  // Brand.
  static const Color primary = Color(0xFF1E6FFF); // Let's Play blue
  static const Color primaryDark = Color(0xFF0B3FB0);

  // Level colors.
  static const Color levelLetters = Color(0xFFFFC400); // yellow
  static const Color levelTashkeel = Color(0xFFF57C00); // orange
  static const Color levelNumbers = Color(0xFF1E9BFF); // blue
  static const Color levelWords = Color(0xFF2ECC40); // green
  static const Color levelSentences = Color(0xFF6C2BD9); // purple

  // Neutrals.
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF4F4F5);
  static const Color border = Color(0xFFE0E0E0);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textOnColor = Color(0xFFFFFFFF);

  // Semantic.
  static const Color success = Color(0xFF2ECC40);
  static const Color error = Color(0xFFE53935);
  static const Color heart = Color(0xFFE53935);
  static const Color coin = Color(0xFFFFC400);

  // Auth & Onboarding.
  static const Color loginBackground = Color(0xFF1400FF);
  static const Color accentCyan = Color(0xFF00E5D0);
  static const Color accentPink = Color(0xFFFF2D6F);
  static const Color facebookSurface = Color(0xFFFFFFFF);
  static const Color progressTrack = Color(0xFFE0E0E0);
  // Layout shell / bottom navigation.
  static const Color navBarBackground = Color(0xFFFFFFFF);
  static const Color navBarBorder = Color(0xFFEDEDED);
  static const Color navBarSelectedSurface = Color(0xFFF1F5FF);

  // Splash.
  static const Color splashYellow = Color(0xFFFEDD05);
  static const Color splashRed = Color(0xFFFF2D55);
  static const Color splashLogo = Color(0xFFFFDD00);

  // Neo-brutalist accents (level headers, letter tiles).
  static const Color ink = Color(0xFF000000);

  // "Form the letter" game.
  static const Color brickOrange = Color(0xFFF5871F);
  static const Color brickRed = Color(0xFFE8305A);
  static const Color brickGreen = Color(0xFF22C55E);
  static const Color brickGrey = Color(0xFFE9E9EB);
  static const Color gameCanvas = Color(0xFFFFFFFF);
  static const Color gameDot = Color(0xFFE4E4E7);
  static const Color slotOutline = Color(0xFFD4D4D8);
}
