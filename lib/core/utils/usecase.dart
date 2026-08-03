import 'package:dartz/dartz.dart';

import 'app_imports.dart';

/// Base contract for all use cases.
/// [T] is the success value, [Params] the input.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Use for use cases that take no arguments.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
