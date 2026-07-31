import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/dependency_injection/injection.dart';
import '../../../../core/routing/app_routes.dart';
import '../../domain/entities/onboarding_option.dart';
import '../../domain/entities/onboarding_question.dart';
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

        if (question.step == OnboardingStep.launching) {
          return _LaunchingScreen(question: question);
        }

        return Column(
          children: [
            // ── Header ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      if (state.currentStepIndex > 0)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => context.read<OnboardingCubit>().previousStep(),
                            child: const Text(
                              '<',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        
                      const Text(
                        'Tell us about yourself',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Progress Bar
                  Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: (state.currentStepIndex + 1) / state.questions.length,
                      child: Container(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Banner (Blue Box) ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  color: question.bannerColor,
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: Text(
                  question.bannerText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                  ),
                ),
              ),
            ),

            // ── Options ─────────────────────────────────────────────
            Expanded(
              child: switch (question.step) {
                // Benefits step: list of cards + continue button
                OnboardingStep.benefits => Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          itemCount: question.options.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final option = question.options[index];
                            return _BenefitCard(option: option);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: _NeoBrutalistButton(
                          text: 'CONTINUE',
                          onTap: () => context.read<OnboardingCubit>().nextStep(),
                        ),
                      ),
                    ],
                  ),
                OnboardingStep.startingPoint => ListView.separated(
                    padding: const EdgeInsets.all(24),
                    itemCount: question.options.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final option = question.options[index];
                      return _StartingPointCard(
                        option: option,
                        onTap: () => _handleSelection(context, question.step, option),
                      );
                    },
                  ),
                // Reason step is a 2-column icon grid per the design.
                OnboardingStep.reason => GridView.builder(
                    padding: const EdgeInsets.all(AppDimensions.spaceMd),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: AppDimensions.onboardingGridSpacing,
                      crossAxisSpacing: AppDimensions.onboardingGridSpacing,
                      childAspectRatio:
                          AppDimensions.onboardingGridChildAspectRatio,
                    ),
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final option = question.options[index];
                      return _OptionGridCard(
                        option: option,
                        onTap: () => _handleSelection(
                          context,
                          question.step,
                          option,
                        ),
                      );
                    },
                  ),
                _ => ListView.separated(
                    padding: const EdgeInsets.all(AppDimensions.spaceMd),
                    itemCount: question.options.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppDimensions.spaceSm),
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
              },
            ),

            // Back button removed from bottom since it is now in the header
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

// ── Option grid card widget (reason step) ───────────────────────────────────

/// Square card used for the "why study Arabic?" step: an SVG icon on top,
/// caption below.
class _OptionGridCard extends StatelessWidget {
  const _OptionGridCard({required this.option, required this.onTap});

  final OnboardingOption option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (option.assetPath != null)
                SvgPicture.asset(
                  option.assetPath!,
                  width: 56,
                  height: 56,
                ),
              const SizedBox(height: 12),
              Text(
                option.label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Benefit card widget (benefits step) ───────────────────────────────────

class _BenefitCard extends StatelessWidget {
  const _BenefitCard({required this.option});
  final OnboardingOption option;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (option.assetPath != null) ...[
              SvgPicture.asset(
                option.assetPath!,
                width: 60,
                height: 60,
              ),
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.label,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                  if (option.trailingLabel != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      option.trailingLabel!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeoBrutalistButton extends StatelessWidget {
  const _NeoBrutalistButton({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}

class _StartingPointCard extends StatelessWidget {
  const _StartingPointCard({required this.option, required this.onTap});
  final OnboardingOption option;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (option.assetPath != null) ...[
                SvgPicture.asset(
                  option.assetPath!,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Text(
                  option.label,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Launching Screen ──────────────────────────────────────────────────────────

class _LaunchingScreen extends StatelessWidget {
  const _LaunchingScreen({required this.question});
  final OnboardingQuestion question;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: question.bannerColor, // blue
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => context.read<OnboardingCubit>().previousStep(),
                ),
              ),
              const SizedBox(height: 16),
              SvgPicture.asset(
                AppAssets.splashLogo,
                width: 90,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              const SizedBox(height: 16),
              const Text(
                'Launching',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    final option = question.options[index];
                    return _PremiumFeatureCard(option: option);
                  },
                ),
              ),
              const SizedBox(height: 16),
              _NeoBrutalistButton(
                text: 'Notify Me',
                onTap: () => context.read<OnboardingCubit>().nextStep(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _PremiumFeatureCard extends StatelessWidget {
  const _PremiumFeatureCard({required this.option});
  final OnboardingOption option;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.transparent, 
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          if (option.assetPath != null) ...[
            SvgPicture.asset(
              option.assetPath!,
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 20),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  option.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (option.trailingLabel != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    option.trailingLabel!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}



