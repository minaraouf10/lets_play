import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/login_footer.dart';
import '../widgets/login_social_row.dart';
import '../widgets/remember_me_row.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.loginBackground,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              context.goNamed(AppRoutes.onboardingName);
            } else if (state.status == AuthStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Login failed')),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state.status == AuthStatus.loading;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.spaceLg,
                vertical: AppDimensions.spaceLg,
              ),
              child: Form(
                key: _formKey,
                child: Column(
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
                      controller: _emailController,
                      hintText: 'Email address',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: Validators.email,
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    AppTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      validator: Validators.password,
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    RememberMeRow(
                      onForgotPasswordPressed: () => _showComingSoon(context),
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.accentCyan,
                          width: AppDimensions.borderWidthSelected,
                        ),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMd),
                      ),
                      child: AppButton(
                        label: 'Sign in',
                        color: AppColors.background,
                        textColor: AppColors.textPrimary,
                        isLoading: isLoading,
                        onPressed: () => _submit(context),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    AppButton(
                      label: 'Login with Facebook',
                      color: AppColors.facebookSurface,
                      textColor: AppColors.textPrimary,
                      onPressed: () => _showComingSoon(context),
                    ),
                    const SizedBox(height: AppDimensions.spaceXl),
                    LoginSocialRow(
                      onTwitterPressed: () => _showComingSoon(context),
                      onGooglePressed: () => _showComingSoon(context),
                    ),
                    const SizedBox(height: AppDimensions.spaceXl),
                    LoginFooter(
                      onSignUpPressed: () => _showComingSoon(context),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
