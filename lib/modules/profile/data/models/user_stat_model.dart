import '../../domain/entities/stat_kind.dart';
import '../../domain/entities/user_stat.dart';

class UserStatModel extends UserStat {
  const UserStatModel({
    required super.kind,
    required super.value,
  });

  factory UserStatModel.fromMap(Map<String, dynamic> map) {
    return UserStatModel(
      kind: StatKind.values.byName(map['kind'] as String),
      value: map['value'] as int,
    );
  }
}
