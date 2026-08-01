import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../domain/entities/onboarding_option.dart';
import '../../domain/entities/onboarding_question.dart';
import '../../domain/entities/onboarding_step.dart';
import 'benefit_card.dart';
import 'neo_brutalist_button.dart';
import 'option_grid_card.dart';
import 'option_tile.dart';
import 'starting_point_card.dart';

class OnboardingOptionsBody extends StatelessWidget {
  const OnboardingOptionsBody({
    super.key,
    required this.question,
    required this.onSelect,
    required this.onContinue,
  });

  final OnboardingQuestion question;
  final void Function(OnboardingOption) onSelect;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return switch (question.step) {
      OnboardingStep.benefits => Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                itemCount: question.options.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final option = question.options[index];
                  return BenefitCard(option: option);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: NeoBrutalistButton(
                text: 'CONTINUE',
                onTap: onContinue,
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
            return StartingPointCard(
              option: option,
              onTap: () => onSelect(option),
            );
          },
        ),
      OnboardingStep.reason => GridView.builder(
          padding: const EdgeInsets.all(AppDimensions.spaceMd),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: AppDimensions.onboardingGridSpacing,
            crossAxisSpacing: AppDimensions.onboardingGridSpacing,
            childAspectRatio: AppDimensions.onboardingGridChildAspectRatio,
          ),
          itemCount: question.options.length,
          itemBuilder: (context, index) {
            final option = question.options[index];
            return OptionGridCard(
              option: option,
              onTap: () => onSelect(option),
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
            return OptionTile(
              option: option,
              onTap: () => onSelect(option),
            );
          },
        ),
    };
  }
}
