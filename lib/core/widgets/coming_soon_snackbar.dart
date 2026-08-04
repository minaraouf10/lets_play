import '../utils/app_imports.dart';

extension ComingSoonSnackBar on BuildContext {
  void showComingSoon([String? feature]) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          feature != null ? 'Coming soon: $feature' : 'Coming soon',
          style: AppTextStyles.bodyMedium,
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
