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
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.errorMessage ?? 'An error occurred',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<OnboardingCubit>().load(),
                child: const Text('Retry'),
              ),
            ],
          ),
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
        return Column(
          children: [
            // ── Banner ──────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 28,
              ),
              color: question.bannerColor,
              child: Text(
                question.bannerText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
            ),

            // ── Options ─────────────────────────────────────────────
            Expanded(
              child: question.step == OnboardingStep.benefits
                  // Benefits step has no options — show a "Next" button
                  ? Center(
                      child: ElevatedButton(
                        onPressed: () =>
                            context.read<OnboardingCubit>().nextStep(),
                        child: const Text('Continue'),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: question.options.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final option = question.options[index];
                        return _OptionTile(
                          option: option,
                          onTap: () => _handleSelection(
                            context,
                            question.step,
                            option,
                          ),
                        );
                      },
                    ),
            ),

            // ── Back button ─────────────────────────────────────────
            if (state.currentStepIndex > 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextButton(
                  onPressed: () =>
                      context.read<OnboardingCubit>().previousStep(),
                  child: const Text('Back'),
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
      case OnboardingStep.startingPoint:
        cubit.selectStartingPoint(option.id);
      case OnboardingStep.benefits:
        cubit.nextStep();
    }
  }
}

// ── Option tile widget ────────────────────────────────────────────────────────

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.option, required this.onTap});

  final OnboardingOption option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              if (option.assetPath != null) ...[
                Image.asset(
                  option.assetPath!,
                  width: 28,
                  height: 28,
                  errorBuilder: (_, _, _) => const SizedBox(width: 28),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  option.label,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              if (option.trailingLabel != null)
                Text(
                  option.trailingLabel!,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
