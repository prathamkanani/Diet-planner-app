import 'package:supabase_flutter/supabase_flutter.dart';
import '../application/logic/auth/auth_cubit.dart';
import '../application/logic/profile/profile_cubit.dart';
import '../application/service/auth_service.dart';
import '../application/service/locator.dart';
import '../domain/repository/auth_repository.dart';
import '../domain/repository/profile_repository.dart';
import 'repository/auth_repository.dart';
import 'repository/profile_repository.dart';
import 'service/auth_service.dart';
import 'source/auth_source.dart';
import 'source/profile_source.dart';

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
    locator.registerSingleton(Supabase.instance.client);

    // Registering Federated Auth service
    locator.registerFactory<FederatedAuthService>(() => AuthService());

    // Registering Auth dependencies
    locator.registerFactory<SupabaseAuthSource>(
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
    locator.registerFactory<ProfileRemoteDataSource>(
          () => ProfileRemoteDataSource(locator.get()),
    );
    locator.registerFactory<ProfileRepository>(
          () => ProfileRepositoryImpl(locator.get()),
    );
    locator.registerFactory<ProfileCubit>(
          () => ProfileCubit(repository: locator.get()),
    );
  }
}
