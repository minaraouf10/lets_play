import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/onboarding_option.dart';

class PremiumFeatureCard extends StatelessWidget {
  const PremiumFeatureCard({super.key, required this.option});
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
