import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_option.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({super.key, required this.option, required this.onTap});

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
