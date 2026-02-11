import 'package:bloc/bloc.dart';
import '../../../domain/repository/bootstrap_repository.dart';
import '../../../infrastructure/app_injector.dart';
import '../../service/app_data_service.dart';
import 'bootstrap_state.dart';

class BootstrapCubit extends Cubit<BootstrapState> {
  final BootstrapRepository repository;

  BootstrapCubit(this.repository) : super(const BootstrapLoadingState());

  final AppDataService appDataService = locator.get();

  // void isUserAuth() async {
  //   try {
  //     final isUserAuthenticated = repository.isUserAuthenticated();
  //     await Future.delayed(const Duration(microseconds: 1));
  //     isUserAuthenticated
  //         ? emit(const UserAuthenticatedState())
  //         : emit(const UserUnauthenticatedState());
  //   } catch (e) {
  //     emit(BootstrapErrorState(e));
  //   }
  // }

  Future<void> isOnboardingCompleted() async {
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
      await Future.delayed(const Duration(microseconds: 1));
      emit(const UserUnauthenticatedState());
    } catch (e) {
      emit(BootstrapErrorState(e));
    }
  }
}
