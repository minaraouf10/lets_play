import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'onboarding_option.dart';
import 'onboarding_step.dart';

class OnboardingQuestion extends Equatable {
  const OnboardingQuestion({
    required this.step,
    required this.bannerText,
    required this.bannerColor,
    required this.options,
  });

  final OnboardingStep step;
  final String bannerText;
  final Color bannerColor;
  final List<OnboardingOption> options;

  @override
  List<Object?> get props => [step, bannerText, bannerColor, options];
}
