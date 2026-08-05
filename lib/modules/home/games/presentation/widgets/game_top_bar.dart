import '../../../../../core/utils/app_imports.dart';

import 'game_progress_bar.dart';

/// Close button, hearts count, and progress bar.
class GameTopBar extends StatelessWidget {
  const GameTopBar({
    super.key,
    required this.hearts,
    required this.progress,
    required this.onClose,
    this.heartsLeading = false,
  });

  final int hearts;
  final double progress;
  final VoidCallback onClose;

  /// When true, renders X → hearts → progress bar instead of the default
  /// X → progress bar → hearts.
  final bool heartsLeading;

  @override
  Widget build(BuildContext context) {
    final heart = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.favorite_rounded, color: AppColors.heart, size: AppDimensions.iconMd),
        const SizedBox(width: AppDimensions.spaceXs),
        Text('$hearts', style: AppTextStyles.bodyMedium),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceMd),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: onClose,
          ),
          if (heartsLeading) ...[
            heart,
            const SizedBox(width: AppDimensions.spaceSm),
            Expanded(child: GameProgressBar(progress: progress)),
          ] else ...[
            Expanded(child: GameProgressBar(progress: progress)),
            const SizedBox(width: AppDimensions.spaceSm),
            heart,
          ],
        ],
      ),
    );
  }
}
