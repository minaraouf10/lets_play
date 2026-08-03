import 'package:dartz/dartz.dart';

import '../../../../core/utils/app_imports.dart';


@lazySingleton
class LogoutUseCase implements UseCase<Unit, NoParams> {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) => _repository.logout();
}
