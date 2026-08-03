import '../../../../core/utils/app_imports.dart';


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
    // if (_formKey.currentState?.validate() ?? false) {
    //   context.read<AuthCubit>().login(
    //         email: _emailController.text.trim(),
    //         password: _passwordController.text,
    //       );
    // }
    context.goNamed(AppRoutes.onboardingName);
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
           // if (state.status == AuthStatus.authenticated) {
              context.goNamed(AppRoutes.onboardingName);
            // } else if (state.status == AuthStatus.error) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(content: Text(state.errorMessage ?? 'Login failed')),
            //   );
            // }
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
                child: LoginFormBody(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isLoading: isLoading,
                  onSubmit: () => _submit(context),
                  onForgotPassword: () => _showComingSoon(context),
                  onFacebookLogin: () => _showComingSoon(context),
                  onTwitter: () => _showComingSoon(context),
                  onGoogle: () => _showComingSoon(context),
                  onSignUp: () => _showComingSoon(context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
