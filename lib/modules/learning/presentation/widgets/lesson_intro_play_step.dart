import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/level_type.dart';
import 'level_color_mapper.dart';

/// Step 2 of the lesson intro flow: "tap the blocks" instructions; LETS
/// PLAY replaces this route with the actual puzzle screen.
class LessonIntroPlayStep extends StatelessWidget {
  const LessonIntroPlayStep({
    super.key,
    required this.levelType,
    required this.lessonId,
  });

  final LevelType levelType;
  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: levelType.color,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.ink),
                  onPressed: () => context.pop(),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.spaceMd),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                  border: Border.all(
                    color: AppColors.ink,
                    width: AppDimensions.neoBorderWidth,
                  ),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Tap on the blocks',
                      style: AppTextStyles.cardTitle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'To form the letter',
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(AppAssets.tapOnTheBlocksImage),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              SizedBox(
                width: double.infinity,
                height: AppDimensions.buttonHeight,
                child: OutlinedButton(
                  onPressed: () => context.pushReplacementNamed(
                    AppRoutes.letterGameName,
                    queryParameters: {'lessonId': lessonId},
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.background,
                    side: const BorderSide(
                      color: AppColors.ink,
                      width: AppDimensions.neoBorderWidth,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                    ),
                  ),
                  child: Text(
                    'LETS PLAY',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
