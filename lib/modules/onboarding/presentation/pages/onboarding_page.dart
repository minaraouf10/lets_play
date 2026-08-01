import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/routing/app_routes.dart';
import '../../domain/entities/onboarding_option.dart';
import '../../domain/entities/onboarding_step.dart';
import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/launching_screen.dart';
import '../widgets/onboarding_banner.dart';
import '../widgets/onboarding_error_view.dart';
import '../widgets/onboarding_options_body.dart';
import '../widgets/onboarding_step_header.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>()..load(),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == OnboardingStatus.completed) {
          context.goNamed(
            AppRoutes.levelsName,
            queryParameters: const {'lessonId': AppConstants.firstLessonId},
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, OnboardingState state) {
    switch (state.status) {
      case OnboardingStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case OnboardingStatus.error:
        return OnboardingErrorView(
          message: state.errorMessage,
          onRetry: () => context.read<OnboardingCubit>().load(),
        );
      case OnboardingStatus.completed:
        return const Center(child: Text('Onboarding complete!'));
      case OnboardingStatus.initial:
      case OnboardingStatus.ready:
      case OnboardingStatus.submitting:
        if (state.questions.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        final question = state.questions[state.currentStepIndex];
        if (question.step == OnboardingStep.launching) {
          return LaunchingScreen(question: question);
        }
        return Column(
          children: [
            OnboardingStepHeader(
              showBackButton: state.currentStepIndex > 0,
              progress: (state.currentStepIndex + 1) / state.questions.length,
              onBack: () => context.read<OnboardingCubit>().previousStep(),
            ),
            OnboardingBanner(color: question.bannerColor, text: question.bannerText),
            Expanded(
              child: OnboardingOptionsBody(
                question: question,
                onSelect: (option) => _handleSelection(context, question.step, option),
                onContinue: () => context.read<OnboardingCubit>().nextStep(),
              ),
            ),
          ],
        );
    }
  }

  /// Routes the selection to the correct cubit method based on the step.
  void _handleSelection(
    BuildContext context,
    OnboardingStep step,
    OnboardingOption option,
  ) {
    final cubit = context.read<OnboardingCubit>();
    switch (step) {
      case OnboardingStep.reason:
        cubit.selectReason(option.id);
      case OnboardingStep.proficiency:
        cubit.selectProficiency(option.id);
      case OnboardingStep.dailyGoal:
        cubit.selectDailyGoal(int.tryParse(option.id) ?? 0);
      case OnboardingStep.dialect:
        cubit.selectDialect(option.id);
      case OnboardingStep.launching:
        cubit.nextStep();
      case OnboardingStep.startingPoint:
        cubit.selectStartingPoint(option.id);
      case OnboardingStep.benefits:
        cubit.nextStep();
    }
  }
}

