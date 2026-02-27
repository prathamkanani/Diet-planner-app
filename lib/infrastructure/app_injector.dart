import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../application/logic/auth/auth_cubit.dart';
import '../application/logic/bootstrap/bootstrap_cubit.dart';
import '../application/logic/chat/chat_cubit.dart';
import '../application/logic/meal_load/meal_cubit.dart';
import '../application/logic/meal_log/meal_log_cubit.dart';
import '../application/logic/onboarding/onboarding_cubit.dart';
import '../application/logic/profile/profile_cubit.dart';
import '../application/logic/report/report_cubit.dart';
import '../application/service/app_data_service.dart';
import '../application/service/auth_service.dart';
import '../application/service/locator.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/bootstrap_repository.dart';
import '../domain/repository/chat_repository.dart';
import '../domain/repository/meal_logger_repository.dart';
import '../domain/repository/meal_repository.dart';
import '../domain/repository/onboarding_repository.dart';
import '../domain/repository/profile_repository.dart';
import '../domain/repository/report_repository.dart';
import '../env.dart';
import 'repository/auth_repository.dart';
import 'repository/bootstrap_repository.dart';
import 'repository/chat_repository.dart';
import 'repository/meal_repository.dart';
import 'repository/meal_logger_repository.dart';
import 'repository/onboarding_repository.dart';
import 'repository/profile_repository.dart';
import 'repository/report_repository.dart';
import 'service/app_data_service.dart';
import 'service/auth_service.dart';
import 'service/gemini_client_service.dart';
import 'service/gemini_functional_service.dart';
import 'source/auth_source.dart';
import 'source/bootstrap_source.dart';
import 'source/meal_source.dart';
import 'source/meal_log_source.dart';
import 'source/onboard_source.dart';
import 'source/profile_source.dart';
import 'source/report_source.dart';
import 'source/supabase_init.dart';

/// Global instance for locator
final Locator locator = LocatorImpl();

/// Defines the contract for service locator based of flavor of the application.
abstract interface class AppInjector {
  /// Injects all the dependencies and initialize services.
  Future<void> init();
}

/// Service locator for development.
class DependencyInjector implements AppInjector {
  @override
  Future<void> init() async {
    // Initialise supabase.
    await SupabaseConfig.initializeSupabase();
    final supabase = Supabase.instance.client;

    // Initialise gemini.
    Gemini.init(apiKey: geminiKey);

    // Initialise shared preference.
    final sharedPref = await SharedPreferences.getInstance();

    locator.registerSingleton(supabase);
    locator.registerSingleton(GeminiClientService());
    locator.registerSingleton(sharedPref);
    // Registering AppDataService
    locator.registerSingleton<AppDataService>(AppDataServiceImpl());

    locator.registerFactory<BootstrapSource>(
      () => SupabaseBSource(locator.get<SupabaseClient>()),
    );
    locator.registerFactory<BootstrapRepository>(
      () => BootstrapRepositoryImpl(locator.get<BootstrapSource>()),
    );
    locator.registerFactory<BootstrapCubit>(
      () => BootstrapCubit(locator.get<BootstrapRepository>()),
    );

    // Registering Federated Auth service
    locator.registerFactory<FederatedAuthService>(() => AuthService());

    // Registering Auth dependencies
    locator.registerFactory<AuthDataSource>(
      () => SupabaseAuthSource(
        locator.get<SupabaseClient>(),
        locator.get<FederatedAuthService>(),
      ),
    );
    locator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(locator.get()),
    );
    locator.registerFactory<AuthCubit>(
      () => AuthCubit(authRepository: locator.get()),
    );

    // Registering Profile Dependencies
    locator.registerFactory<ProfileSource>(
      () => ProfileRemoteDataSource(locator.get()),
    );
    locator.registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(locator.get()),
    );
    locator.registerFactory<ProfileCubit>(
      () => ProfileCubit(
        repository: locator.get(),
        authRepository: locator.get(),
      ),
    );

    // Registering Onboarding Dependencies
    locator.registerFactory<OnboardingSource>(
      () => OnboardingRemoteSource(locator.get(), locator.get()),
    );
    locator.registerFactory<OnboardingRepository>(
      () => OnboardingRepositoryImpl(locator.get()),
    );
    locator.registerFactory<OnboardingCubit>(
      () => OnboardingCubit(repository: locator.get()),
    );

    // Registering Meal Showing Dependencies
    locator.registerFactory<MealSource>(() => MealRemoteSource(locator.get()));
    locator.registerFactory<MealRepository>(
      () => MealRepositoryImpl(locator.get()),
    );
    locator.registerFactory<MealLoadingCubit>(
      () => MealLoadingCubit(locator.get(), locator.get()),
    );

    // Registering Meal Logging Dependencies
    locator.registerFactory<MealLogSource>(
      () => MealLogRemoteSource(locator.get()),
    );
    locator.registerFactory<MealLoggerRepository>(
      () => MealLoggerRepositoryImpl(locator.get()),
    );
    locator.registerFactory<MealLogCubit>(
      () => MealLogCubit(
        mealRepository: locator.get(),
        mealLoggerRepository: locator.get(),
      ),
    );

    // Registering Report related dependencies
    locator.registerFactory<ReportSource>(
      () => ReportRemoteSource(locator.get()),
    );
    locator.registerFactory<ReportRepository>(
      () => ReportRepositoryImpl(source: locator.get()),
    );
    locator.registerFactory<ReportCubit>(
      () => ReportCubit(repository: locator.get()),
    );

    // Registering Chat related dependencies
    locator.registerFactory<GeminiFunctionalService>(
      () => GeminiFunctionalService(locator.get()),
    );
    locator.registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(locator.get()),
    );
    locator.registerFactory<ChatCubit>(
      () => ChatCubit(repository: locator.get()),
    );
  }
}
