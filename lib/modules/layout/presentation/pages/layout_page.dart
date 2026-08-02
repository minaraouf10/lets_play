import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/layout_bottom_nav_bar.dart';

/// Shell hosting the 4 main tabs. Owns the ONLY Scaffold that carries a
/// bottomNavigationBar; each tab page keeps its own Scaffold for its body.
class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: LayoutBottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          // Re-tapping the active tab pops that branch back to its root.
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
