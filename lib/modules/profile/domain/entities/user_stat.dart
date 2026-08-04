import 'package:equatable/equatable.dart';

import 'stat_kind.dart';

class UserStat extends Equatable {
  const UserStat({
    required this.kind,
    required this.value,
  });

  final StatKind kind;
  final int value;

  @override
  List<Object?> get props => [kind, value];
}
