import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/service/app_data_service.dart';
import '../../domain/entity/daily_meals_entity.dart';
import '../model/daily_meals_model.dart';
import '../utils/helpers.dart';
import '../utils/types.dart';
import '../app_injector.dart';

abstract interface class MealSource {
  Future<DailyMealsEntity?> fetchExistingMeal(
    String mealPlanId,
    DateTime currentDate,
  );

  Future<void> saveGeneratedPlan(JsonList? jsonList);
}

class MealRemoteSource implements MealSource {
  final SupabaseClient supabase;

  final AppDataService appDataService = locator.get();
  late final String userId = appDataService.userId!;

  MealRemoteSource(this.supabase);

  @override
  Future<DailyMealsEntity?> fetchExistingMeal(
    String mealPlanId,
    DateTime currentDate,
  ) async {
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
          .maybeSingle();
      // Generated logs for that day, if any.
      final mealLogs = await supabase
          .from('meal_logs')
          .select('meal_type, option, calories')
          .eq('meal_id', response?['id']);
      return DailyMealsModel.fromJson(currentDate, response, mealLogs);
    }
    return null;
  }

  @override
  Future<void> saveGeneratedPlan(JsonList? jsonList) async {
    final res = await supabase
        .from('meal_plan')
        .insert({
          'user_id': appDataService.userId,
          'plan_start': appDataService.planStartDate.toString(),
        })
        .select()
        .single();

    final String mealPlanId = res['id'];
    appDataService.mealPlanId = mealPlanId;

    final daysPayload = jsonList?.map((day) {
      return {
        'meal_plan_id': appDataService.mealPlanId,
        'day': weekdayLabelToInt(day['day']),
        'meal': day['meals'],
      };
    }).toList();

    await supabase.from('meal_plan_days').insert(daysPayload!);
  }
}
