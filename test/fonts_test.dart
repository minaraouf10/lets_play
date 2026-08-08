import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lets_play/core/theme/app_text_styles.dart';
import 'package:lets_play/core/theme/app_theme.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('font registration', () {
    late YamlMap pubspec;

    setUpAll(() {
      pubspec = loadYaml(File('pubspec.yaml').readAsStringSync()) as YamlMap;
    });

    test('the family declared in pubspec matches the one the code uses', () {
      final fonts = (pubspec['flutter'] as YamlMap)['fonts'] as YamlList;
      final families = fonts.map((f) => (f as YamlMap)['family']).toList();

      expect(
        families,
        contains(AppTextStyles.fontFamily),
        reason: 'AppTextStyles.fontFamily must name a family in pubspec.yaml',
      );
    });

    test('the Arabic fallback family is declared in pubspec', () {
      final fonts = (pubspec['flutter'] as YamlMap)['fonts'] as YamlList;
      final families = fonts.map((f) => (f as YamlMap)['family']).toList();

      expect(
        families,
        contains(AppTextStyles.arabicFontFamily),
        reason: 'the Arabic fallback must name a family in pubspec.yaml, '
            'or Arabic glyphs fall through to a platform font that drops '
            'the hamza on "أ"',
      );
    });

    test('every declared font asset exists on disk', () {
      final fonts = (pubspec['flutter'] as YamlMap)['fonts'] as YamlList;

      for (final family in fonts) {
        for (final font in (family as YamlMap)['fonts'] as YamlList) {
          final asset = (font as YamlMap)['asset'] as String;
          expect(
            File(asset).existsSync(),
            isTrue,
            reason: '$asset is declared in pubspec.yaml but missing on disk',
          );
        }
      }
    });
  });

  group('font application', () {
    test('every AppTextStyles entry carries the family', () {
      // Guards against a new style being added without a fontFamily, which
      // would silently fall back to the system font wherever it is used
      // outside a Material text context.
      const styles = <String, TextStyle>{
        'headingLarge': AppTextStyles.headingLarge,
        'headingMedium': AppTextStyles.headingMedium,
        'bodyLarge': AppTextStyles.bodyLarge,
        'bodyMedium': AppTextStyles.bodyMedium,
        'bodySmall': AppTextStyles.bodySmall,
        'button': AppTextStyles.button,
        'cardTitle': AppTextStyles.cardTitle,
        'bannerText': AppTextStyles.bannerText,
        'wordGlyph': AppTextStyles.wordGlyph,
        'screenTitle': AppTextStyles.screenTitle,
        'statValue': AppTextStyles.statValue,
        'totalPointsValue': AppTextStyles.totalPointsValue,
      };

      styles.forEach((name, style) {
        expect(
          style.fontFamily,
          AppTextStyles.fontFamily,
          reason: 'AppTextStyles.$name is missing the app font family',
        );
        expect(
          style.fontFamilyFallback,
          contains(AppTextStyles.arabicFontFamily),
          reason: 'AppTextStyles.$name has no Arabic fallback, so Arabic '
              'text using it would lose its hamza and tashkeel',
        );
      });
    });

    test('the theme applies the family to entries it does not override', () {
      final theme = AppTheme.light;

      // bodyLarge is overridden explicitly; labelLarge is not — both must
      // still resolve to the app font.
      expect(theme.textTheme.bodyLarge?.fontFamily, AppTextStyles.fontFamily);
      expect(theme.textTheme.labelLarge?.fontFamily, AppTextStyles.fontFamily);
      expect(theme.textTheme.titleMedium?.fontFamily, AppTextStyles.fontFamily);
      expect(
        theme.primaryTextTheme.bodyMedium?.fontFamily,
        AppTextStyles.fontFamily,
      );
    });

    test('the theme carries the Arabic fallback on entries it does not '
        'override', () {
      final theme = AppTheme.light;

      // Widgets that build a bare TextStyle inherit from these, so the
      // fallback has to be here too — not only on AppTextStyles.
      for (final style in [
        theme.textTheme.bodyLarge,
        theme.textTheme.labelLarge,
        theme.textTheme.titleMedium,
        theme.primaryTextTheme.bodyMedium,
      ]) {
        expect(
          style?.fontFamilyFallback,
          contains(AppTextStyles.arabicFontFamily),
        );
      }
    });
  });
}
