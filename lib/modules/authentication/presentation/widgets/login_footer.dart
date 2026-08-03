
import '../../../../core/utils/app_imports.dart';


class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
    required this.onSignUpPressed,
  });

  final VoidCallback onSignUpPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "Don't have an account? ",
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textOnColor),
          children: [
            TextSpan(
              text: 'Sign up',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.accentPink,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = onSignUpPressed,
            ),
          ],
        ),
      ),
    );
  }
}
