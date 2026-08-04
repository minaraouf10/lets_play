import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/stat_kind.dart';

extension StatKindStyle on StatKind {
  Color get color => switch (this) {
        StatKind.energy => AppColors.statEnergy,
        StatKind.hearts => AppColors.statHearts,
        StatKind.points => AppColors.statPoints,
      };

  String get asset => switch (this) {
        StatKind.energy => AppAssets.hudEnergy,
        StatKind.hearts => AppAssets.hudHeart,
        StatKind.points => AppAssets.navStar,
      };
}
