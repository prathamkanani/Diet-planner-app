import 'dart:convert';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entity/onboarding_entity.dart';
import '../model/onboarding_model.dart';

abstract interface class OnboardingSource {
  Future<OnboardingEntity> saveOnboardingDetails(OnboardingEntity onboard);

  Stream<Map<String, dynamic>> generateMealPlan(OnboardingEntity onboard);
}

class OnboardingRemoteSource implements OnboardingSource {
  final SupabaseClient supabase;

  OnboardingRemoteSource(this.supabase);

  late final User user = supabase.auth.currentUser!;

  @override
  Future<OnboardingEntity> saveOnboardingDetails(
    OnboardingEntity onboard,
  ) async {
    final Map<String, dynamic> response = await supabase
        .from('user_preferences')
        .insert({})
        .select()
        .single();
    return OnboardingModel.fromJson(response);
  }

  @override
  Stream<Map<String, dynamic>> generateMealPlan(
    OnboardingEntity onboard,
  ) async* {
    Stream<Candidates?> candidates = Gemini.instance.promptStream(
      parts: [
        Part.text(
          '''Role: Act as an expert AI Nutritionist and Culinary Consultant specializing in regional cuisines and behavioral health.

          Objective: Generate a bespoke meal plan based on the specific variables provided below. The plan must be culturally relevant, calorically accurate, and integrated with the user's lifestyle habits.
      
          STRICT OUTPUT RULE: 
          Return ONLY a valid JSON string. Do not include any introductory text, markdown code blocks (```json), or closing remarks. The output must be parseable by a standard JSON parser.
      
          Input Variables:
      
          Location: ${onboard.country} (Source ingredients and flavor profiles local to this region).
      
          Activity Level: ${onboard.activityLevelEntity.title} [Not very active, Lightly active, Active, Very Active](Scale macronutrients accordingly).
      
          Planning Horizon: Weekly.
      
          Core Health Habit: ${onboard.healthHabits}.
      
          Included Meals: [Breakfast, Lunch, Dinner].
      
          Instructions for Output:
      
          Contextual Adaptation: Tailor all recipes to the Country provided, ensuring ingredients are accessible in local markets.
      
          Caloric Precision: Distribute the Target Calories across the meal types. Provide a calorie estimate for every individual dish.
      
          Activity Scaling: If the Activity Level is 'Very Active', prioritize complex carbohydrates and recovery proteins; if 'Not very active,' prioritize high-fiber and nutrient density.
      
          Required Format for Each Meal:
      
          Meal Type: [Breakfast, Lunch, Dinner]
      
          Dishes Name: [Provide with two options so one can choose between them to be more flexible].
      
          Calories: [Calories].
          
          Protein: [value in grams].
          
          Carbohydrates: [value in grams]
          
          Fat: [value in grams]''',
        ),
      ],
    );

    await for (final candidate in candidates) {
      if (candidate?.output case String output) {
        yield jsonDecode(output);
      }
      if (candidate?.finishReason != null) return;
    }
  }
}
