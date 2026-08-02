import 'package:flutter/material.dart';

import '../widgets/coming_soon_view.dart';

/// Emoji tab. Placeholder until the profile feature gets its own module.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: ComingSoonView(title: 'Profile'),
      ),
    );
  }
}
