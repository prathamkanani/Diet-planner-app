import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'application/service/app_data_service.dart';
import 'env.dart';
import 'frontend/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'frontend/pages/bootstrap/bootstrap_page.dart';
import 'frontend/pages/home/home_page.dart';
import 'frontend/pages/login/login_page.dart';
import 'generated/l10n.dart';
import 'infrastructure/app_injector.dart';
import 'infrastructure/source/supabase_init.dart';

void main() async {
  // To ensure that framework is completely loaded before accessing native
  // resources using platform channels.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise supabase.
  await SupabaseConfig.initializeSupabase();

  Gemini.init(apiKey: geminiKey);

  // Locate the dependencies.
  await DependencyInjector().init();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  locator.registerSingleton(preferences);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppDataService appDataService = locator.get();

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
      home: appDataService.userId != null
          ? appDataService.isUserLoggedIn
                ? const HomePage()
                : const LoginPage()
          : const BootstrapPage(),
    );
  }
}
