
import '../../../../core/utils/app_imports.dart';



class LoginFormBody extends StatelessWidget {
  const LoginFormBody({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onSubmit,
    required this.onForgotPassword,
    required this.onFacebookLogin,
    required this.onTwitter,
    required this.onGoogle,
    required this.onSignUp,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onForgotPassword;
  final VoidCallback onFacebookLogin;
  final VoidCallback onTwitter;
  final VoidCallback onGoogle;
  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppDimensions.spaceXl),
        Text(
          'Login',
          textAlign: TextAlign.center,
          style: AppTextStyles.headingLarge
              .copyWith(color: AppColors.textOnColor),
        ),
        const SizedBox(height: AppDimensions.spaceSm),
        Text(
          "You don't think you should login first and behave like human not robot.",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.textOnColor),
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        AppTextField(
          controller: emailController,
          hintText: 'Email address',
          prefixIcon: Icons.person_outline,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: Validators.email,
        ),
        const SizedBox(height: AppDimensions.spaceMd),
        AppTextField(
          controller: passwordController,
          hintText: 'Password',
          prefixIcon: Icons.lock_outline,
          obscureText: true,
          textInputAction: TextInputAction.done,
          validator: Validators.password,
        ),
        const SizedBox(height: AppDimensions.spaceMd),
        RememberMeRow(
          onForgotPasswordPressed: onForgotPassword,
        ),
        const SizedBox(height: AppDimensions.spaceLg),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.accentCyan,
              width: AppDimensions.borderWidthSelected,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: AppButton(
            label: 'Sign in',
            color: AppColors.background,
            textColor: AppColors.textPrimary,
            isLoading: isLoading,
            onPressed: onSubmit,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceMd),
        AppButton(
          label: 'Login with Facebook',
          color: AppColors.facebookSurface,
          textColor: AppColors.textPrimary,
          onPressed: onFacebookLogin,
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        LoginSocialRow(
          onTwitterPressed: onTwitter,
          onGooglePressed: onGoogle,
        ),
        const SizedBox(height: AppDimensions.spaceXl),
        LoginFooter(
          onSignUpPressed: onSignUp,
        ),
      ],
    );
  }
}
