import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/service/app_data_service.dart';
import '../../domain/entity/daily_meals_entity.dart';
import '../../domain/entity/user_preferences.dart';
import '../model/daily_meals_model.dart';
import '../utils/helpers.dart';
import '../app_injector.dart';

abstract interface class MealSource {
  Future<DailyMealsEntity?> fetchExistingMeal(DateTime currentDate);

  Future<UserPreferences> getUserPreferences(String userId);
}

class MealRemoteSource implements MealSource {
  final SupabaseClient supabase;

  final AppDataService appDataService = locator.get();
  late final String userId = appDataService.userId!;

  MealRemoteSource(this.supabase);

  @override
  Future<DailyMealsEntity?> fetchExistingMeal(DateTime currentDate) async {
    final res = await supabase
        .from('meal_plan')
        .select()
        .eq('user_id', userId)
        .single();
    final planStartDate = DateTime.parse(res['plan_start']);
    if (isWithinPlan(startDate: planStartDate, currentDate: currentDate)) {
      // Generated meals for a day.
      final response = await supabase
          .from('meal_plan_days')
          .select()
          .eq('day', currentDate.weekday)
          .eq('meal_plan_id', res['id'])
          .maybeSingle();
      // Generated logs for that day, if any.
      final mealLogs = await supabase
          .from('meal_logs')
          .select('meal_type, option, calories, carbs, fats, proteins')
          .eq('meal_id', response?['id']);
      return DailyMealsModel.fromJson(
        currentDate,
        planStartDate,
        response,
        mealLogs,
      );
    }
    return null;
  }

  @override
  Future<UserPreferences> getUserPreferences(String userId) {
    // TODO: implement getUserPreferences
    throw UnimplementedError();
  }
}
