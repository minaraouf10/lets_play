import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../domain/entities/level_type.dart';
import 'level_color_mapper.dart';
import 'lesson_intro_info_box.dart';

/// Step 1 of the lesson intro flow: level-color gradient background, the
/// lesson illustration, the lesson/level info card, and a continue button.
class LessonIntroLessonStep extends StatelessWidget {
  const LessonIntroLessonStep({
    super.key,
    required this.levelType,
    required this.lessonNumber,
    required this.onContinue,
  });

  final LevelType levelType;
  final int lessonNumber;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: levelType.gradient),
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
              Expanded(
                child: SvgPicture.asset(AppAssets.lessonImage),
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              LessonInfoBox(
                lessonNumber: lessonNumber,
                levelNumber: levelType.number,
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              AppButton(
                label: 'CONTINUE',
                color: AppColors.ink,
                onPressed: onContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
