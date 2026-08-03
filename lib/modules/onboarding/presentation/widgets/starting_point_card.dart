import '../../../../core/utils/app_imports.dart';

import '../../domain/entities/onboarding_option.dart';

class StartingPointCard extends StatelessWidget {
  const StartingPointCard({super.key, required this.option, required this.onTap});
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
