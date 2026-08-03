import '../../../../core/utils/app_imports.dart';


import '../widgets/coming_soon_view.dart';

/// Crown tab. Placeholder until the leaderboard feature gets its own module.
class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: ComingSoonView(title: 'Leaderboard'),
      ),
    );
  }
}
