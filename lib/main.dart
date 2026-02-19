import 'frontend/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'frontend/pages/bootstrap/bootstrap_page.dart';
import 'generated/l10n.dart';
import 'infrastructure/app_injector.dart';

void main() async {
  // To ensure that framework is completely loaded before accessing native
  // resources using platform channels.
  WidgetsFlutterBinding.ensureInitialized();

  // Locate the dependencies.
  await DependencyInjector().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const BootstrapPage(),
    );
  }
}
