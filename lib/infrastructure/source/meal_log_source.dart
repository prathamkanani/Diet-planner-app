import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/service/app_data_service.dart';
import '../../domain/entity/meal_entity.dart';
import '../app_injector.dart';

abstract interface class MealLogSource {
  Future<void> logMeal(Map<MealType, MealEntity> logMeals, DateTime date);

  Future<void> deleteLoggedMeal(
    Map<MealType, MealEntity> logMeals,
    DateTime date,
  );
}

class MealLogRemoteSource implements MealLogSource {
  final SupabaseClient supabase;
  final AppDataService appDataService = locator.get();
  late final String userId = appDataService.userId!;

  MealLogRemoteSource(this.supabase);

  @override
  Future<void> logMeal(
    Map<MealType, MealEntity> logMeals,
    DateTime date,
  ) async {
    final response = await supabase
        .from('meal_plan')
        .select('id')
        .eq('plan_start', appDataService.planStartDate!)
        .single();
    final String mealPlanId = response['id'];

    final res = await supabase
        .from('meal_plan_days')
        .select('id')
        .eq('meal_plan_id', mealPlanId)
        .eq('day', date.weekday)
        .single();

    final String mealId = res['id'];
    final mealLog = logMeals.entries.map((meal) {
      return {
        'user_id': appDataService.userId,
        'meal_id': mealId,
        'log_date': date.toString(),
        'meal_type': meal.key.name,
        'option': meal.value.option.name,
        'calories': meal.value.calorie,
        'carbs': meal.value.carbs,
        'fats': meal.value.fat,
        'proteins': meal.value.protein,
      };
    }).toList();

    await supabase.from('meal_logs').insert(mealLog);
  }

  @override
  Future<void> deleteLoggedMeal(
    Map<MealType, MealEntity> logMeals,
    DateTime date,
  ) async {
    final response = await supabase
        .from('meal_plan')
        .select('id')
        .eq('plan_start', appDataService.planStartDate!)
        .single();
    final String mealPlanId = response['id'];

    final res = await supabase
        .from('meal_plan_days')
        .select('id')
        .eq('meal_plan_id', mealPlanId)
        .eq('day', date.weekday)
        .single();

    final String mealId = res['id'];

    await supabase
        .from('meal_logs')
        .delete()
        .eq('meal_id', mealId)
        .inFilter('meal_type', logMeals.keys.map((t) => t.name).toList());
  }
}
