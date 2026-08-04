import '../../../../core/utils/app_imports.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.radius,
    required this.asset,
    this.borderColor,
  });

  final double radius;
  final String asset;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 2)
              : null,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Image.asset(asset, fit: BoxFit.cover),
      ),
    );
  }
}
