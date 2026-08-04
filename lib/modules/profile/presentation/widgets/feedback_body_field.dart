import '../../../../core/utils/app_imports.dart';

class FeedbackBodyField extends StatelessWidget {
  const FeedbackBodyField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: TextEditingController(text: value),
      minLines: 8,
      maxLines: 12,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.surface,
        hintText: 'Tell us your feedback...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        contentPadding: const EdgeInsets.all(AppDimensions.spaceMd),
      ),
    );
  }
}
