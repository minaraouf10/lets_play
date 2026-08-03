import '../../../../core/utils/app_imports.dart';

import '../cubit/splash_cubit.dart';
import '../widgets/splash_gif_view.dart';
import '../widgets/splash_logo_card.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SplashCubit>()..play(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listenWhen: (p, c) => p.stage != c.stage,
      listener: (context, state) {
        if (state.stage == SplashStage.finished) {
          context.goNamed(AppRoutes.loginName);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.splashYellow,
          body: AnimatedSwitcher(
            duration: state.stage == SplashStage.logo
                ? const Duration(milliseconds: 700)
                : Duration.zero,
            transitionBuilder: (child, animation) {
              if (child is SplashLogoCard) {
                return FadeTransition(opacity: animation, child: child);
              }
              return child;
            },
            child: state.stage == SplashStage.gif
                ? const SplashGifView(key: ValueKey('gif'))
                : const SplashLogoCard(key: ValueKey('logo')),
          ),
        );
      },
    );
  }
}
