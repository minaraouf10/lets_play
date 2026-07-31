import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../cubit/splash_cubit.dart';
import '../widgets/splash_brick_frame.dart';
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
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, SplashState state) {
    if (state.stage == SplashStage.logo || state.stage == SplashStage.finished) {
      return SplashLogoCard(
        key: const ValueKey('logo'),
        onTap: () => context.read<SplashCubit>().continueFromLogo(),
      );
    }

    final framePath = AppAssets.splashFrames[state.frameIndex];
    return SplashBrickFrame(
      key: ValueKey(state.frameIndex),
      assetPath: framePath,
    );
  }
}
