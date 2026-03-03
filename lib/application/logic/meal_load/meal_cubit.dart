import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/daily_meals_entity.dart';
import '../../../domain/entity/user_preferences.dart';
import '../../../domain/repository/meal_repository.dart';
import '../../../domain/repository/onboarding_repository.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/utils/helpers.dart';
import '../../../infrastructure/utils/types.dart';
import '../../service/app_data_service.dart';
import 'meal_state.dart';

class MealLoadingCubit extends Cubit<MealState> {
  final MealRepository repository;
  final OnboardingRepository onboardingRepository;

  MealLoadingCubit(this.repository, this.onboardingRepository)
    : selectedDate = DateTime.now(),
      super(const MealLoadingState());

  /// Getting user id to know first time meal generation or not.
  final AppDataService appDataService = locator.get();

  /// Storing selected date.
  DateTime selectedDate;

  /// This checks whether a meal plan exists for a day or do we need
  /// to create another plan starting from today.
  void checkForNewPlan(DateTime mealPlanDate, DateTime currentDate) {
    if (isWithinPlan(startDate: mealPlanDate, currentDate: currentDate)) {
      fetchExistingMealPlan(currentDate);
      return;
    }
    fetchUserPrefsAndGenerateNewPlan(appDataService.userId!, currentDate);
  }

  /// This generates another plan for user based on selected user preferences.
  Future<void> fetchUserPrefsAndGenerateNewPlan(
    String userId,
    DateTime date,
  ) async {
    try {
      final UserPreferences userPref = await repository.getUserPreferences(
        userId,
      );

      final JsonList jsonList = await onboardingRepository.generateMeal(
        userPref,
        date,
      );

      await onboardingRepository.saveGeneratedMeal(jsonList, date);

      fetchExistingMealPlan(date);
    } catch (e) {
      MealErrorState(e);
    }
  }

  /// To fetch updated meals after user logs them.
  Future<void> loadAfterMealLogging() async {
    final DailyMealsEntity? updatedMeals = await repository.fetchExistingMeal(
      selectedDate,
    );
    if (state is MealLoadedState) {
      emit(
        MealLoadedState(
          meals: updatedMeals!.mealOptionListEntity,
          mealLoggerEntity: updatedMeals.mealLoggerEntity,
        ),
      );
    }
  }

  /// To fetch a meal for a certain day from the existing meal plan
  Future<void> fetchExistingMealPlan(DateTime day) async {
    try {
      final DailyMealsEntity? ml = await repository.fetchExistingMeal(day);
      if (ml != null) {
        emit(
          MealLoadedState(
            mealLoggerEntity: ml.mealLoggerEntity,
            meals: ml.mealOptionListEntity,
          ),
        );
        return;
      }
      emit(const MealNotFoundState());
    } catch (e) {
      emit(MealErrorState(e));
    }
  }

  /// When the date is changed to look at previous meals or logs.
  Future<void> changedDate(DateTime date) async {
    if (dateOnly(selectedDate) == dateOnly(date)) return;

    // If current day is picked, passing the date with time so
    // that dashboard shows the right meal according to the time.
    isToday(date) ? selectedDate = DateTime.now() : selectedDate = date;
    emit(const MealLoadingState());

    try {
      checkForNewPlan(appDataService.planStartDate!, selectedDate);
    } catch (e) {
      emit(MealErrorState(e));
    }
  }
}
