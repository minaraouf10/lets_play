import '../../../../core/utils/app_imports.dart';

import 'game_progress_bar.dart';

/// Close button, hearts count, and progress bar.
class GameTopBar extends StatelessWidget {
  const GameTopBar({
    super.key,
    required this.hearts,
    required this.progress,
    required this.onClose,
  });

  final int hearts;
  final double progress;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: onClose,
          ),
          Expanded(child: GameProgressBar(progress: progress)),
          const SizedBox(width: AppDimensions.spaceSm),
          Icon(Icons.favorite_rounded, color: AppColors.heart, size: AppDimensions.iconMd),
          const SizedBox(width: AppDimensions.spaceXs),
          Text('$hearts', style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
