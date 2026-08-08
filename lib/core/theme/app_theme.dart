import '../utils/app_imports.dart';


/// Central ThemeData. Widgets read from Theme.of(context) rather than
/// hardcoding colors/sizes.
class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.primary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      // `apply` puts the typeface on every entry — including the ones not
      // overridden below — so widgets that build a bare TextStyle, or read
      // labelLarge/titleMedium, still get it. The Arabic fallback rides along
      // so an Arabic glyph in any of those entries keeps its hamza/tashkeel.
      textTheme: base.textTheme
          .apply(
            fontFamily: AppTextStyles.fontFamily,
            fontFamilyFallback: AppTextStyles.fontFamilyFallback,
          )
          .copyWith(
            headlineLarge: AppTextStyles.headingLarge,
            headlineMedium: AppTextStyles.headingMedium,
            bodyLarge: AppTextStyles.bodyLarge,
            bodyMedium: AppTextStyles.bodyMedium,
          ),
      primaryTextTheme: base.primaryTextTheme.apply(
        fontFamily: AppTextStyles.fontFamily,
        fontFamilyFallback: AppTextStyles.fontFamilyFallback,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spaceMd,
          vertical: AppDimensions.spaceMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }
}
