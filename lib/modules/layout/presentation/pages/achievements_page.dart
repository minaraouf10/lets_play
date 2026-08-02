import 'package:flutter/material.dart';

import '../widgets/coming_soon_view.dart';

/// Star tab. Placeholder until the achievements feature gets its own module.
class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: ComingSoonView(title: 'Achievements'),
      ),
    );
  }
}
