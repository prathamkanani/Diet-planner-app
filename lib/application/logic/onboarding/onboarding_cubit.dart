import 'package:bloc/bloc.dart';
import '../../../domain/repository/onboarding_repository.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingRepository repository;

  OnboardingCubit({required this.repository}) : super(OnboardingLoadingState());


}
