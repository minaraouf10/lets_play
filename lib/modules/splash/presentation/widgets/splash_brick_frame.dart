import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashBrickFrame extends StatelessWidget {
  final String assetPath;

  const SplashBrickFrame({
    super.key,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SvgPicture.asset(
        assetPath,
        alignment: Alignment.topCenter,
        fit: BoxFit.fitWidth,
        width: MediaQuery.sizeOf(context).width,
      ),
    );
  }
}
