import 'package:bloc/bloc.dart';
import '../../../domain/repository/bootstrap_repository.dart';
import '../../../infrastructure/app_injector.dart';
import '../../service/app_data_service.dart';
import 'bootstrap_state.dart';

class BootstrapCubit extends Cubit<BootstrapState> {
  final BootstrapRepository repository;

  BootstrapCubit(this.repository) : super(const BootstrapInitialState());

  final AppDataService appDataService = locator.get();

  /// This checks whether a user is onboarded or not, if authenticated.
  Future<void> isOnboardingCompleted() async {
    emit(const BootstrapLoadingState());
    try {
      final isUserAuthenticated = repository.isUserAuthenticated();
      if(isUserAuthenticated){
        final isCompleted = await repository.isOnboardingCompleted();
        appDataService.isNewUser = !isCompleted;
        isCompleted
            ? emit(const UserOnboardedState())
            : emit(const UserDidNotOnboardState());
        return;
      }
      emit(const UserUnauthenticatedState());
    } catch (e) {
      emit(BootstrapErrorState(e));
    }
  }
}
