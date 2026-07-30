import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

/// Call once in `main()` before running the app.
///
/// NOTE: `injection.config.dart` is generated. After changing any
/// annotated class run:
///   dart run build_runner build --delete-conflicting-outputs
@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async => getIt.init();
