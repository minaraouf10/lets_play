import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/onboarding_option.dart';

/// Square card used for the "why study Arabic?" step: an SVG icon on top,
/// caption below.
class OptionGridCard extends StatelessWidget {
  const OptionGridCard({super.key, required this.option, required this.onTap});

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
