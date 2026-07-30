import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_constants.dart';
import 'core/dependency_injection/injection.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await configureDependencies();
  runApp(const LetsPlayApp());
}


class LetsPlayApp extends StatelessWidget {
  const LetsPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
      // RTL + Arabic/English support.
      locale: const Locale('en'),
      supportedLocales: const [Locale('en'),Locale('ar')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
