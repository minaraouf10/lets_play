import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../domain/entities/onboarding_question.dart';
import '../cubit/onboarding_cubit.dart';
import 'premium_feature_card.dart';
import 'neo_brutalist_button.dart';

class LaunchingScreen extends StatelessWidget {
  const LaunchingScreen({super.key, required this.question});
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
                    return PremiumFeatureCard(option: option);
                  },
                ),
              ),
              const SizedBox(height: 16),
              NeoBrutalistButton(
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
