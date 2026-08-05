import '../../../../core/utils/app_imports.dart';
import 'stat_tile.dart';

class StatTilesRow extends StatelessWidget {
  const StatTilesRow({
    super.key,
    required this.stats,
  });

  final List<UserStat> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        stats.length,
        (index) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < stats.length - 1 ? AppDimensions.spaceMd : 0,
            ),
            child: StatTile(stat: stats[index]),
          ),
        ),
      ),
    );
  }
}
