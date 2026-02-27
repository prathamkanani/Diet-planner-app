import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repository/bootstrap_repository.dart';
import '../../../infrastructure/app_injector.dart';
import '../../service/app_data_service.dart';
import 'bootstrap_state.dart';

class BootstrapCubit extends Cubit<BootstrapState> {
  final BootstrapRepository repository;

  BootstrapCubit(this.repository) : super(const BootstrapInitialState());

  final AppDataService appDataService = locator.get();

  /// This checks whether a user has onboarded or not, if authenticated.
  Future<void> fetchOnboardingStatus() async {
    emit(const BootstrapLoadingState());
    try {
      final bool isUserAuthenticated = repository.fetchAuthStatus();
      if (isUserAuthenticated) {
        final bool isCompleted = await repository.fetchOnboardingStatus();
        return isCompleted
            ? emit(const UserOnboardedState())
            : emit(const UserDidNotOnboardState());
      }
      await Future.delayed(const Duration(milliseconds: 1));
      return emit(const UserUnauthenticatedState());
    } catch (e) {
      emit(BootstrapErrorState(e));
    }
  }
}
