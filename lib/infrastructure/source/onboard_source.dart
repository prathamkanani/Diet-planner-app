import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entity/onboarding_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../extension/weekday_extension.dart';
import '../model/onboarding_model.dart';
import '../model/profile_model.dart';
import '../service/gemini_client_service.dart';
import '../utils/types.dart';

abstract interface class OnboardingSource {
  Future<OnboardingEntity> saveOnboardingDetails(OnboardingEntity onboard);

  Future<JsonList> generateMealAI(OnboardingEntity onboard);

  Future<void> saveGeneratedPlan(JsonList jsonList);
}

class OnboardingRemoteSource implements OnboardingSource {
  final SupabaseClient supabase;
  final GeminiClientService gemini;

  OnboardingRemoteSource(this.supabase, this.gemini);

  late final User user = supabase.auth.currentUser!;

  @override
  Future<OnboardingEntity> saveOnboardingDetails(
    OnboardingEntity onboard,
  ) async {
    String seed = const Uuid().v4();
    final Map<String, dynamic> res = await supabase
        .from('profiles')
        .insert(
          ProfileModel.fromEntity(
            onboard.profileEntity,
            user.email,
            seed,
          ).toJson(),
        )
        .select()
        .single();

    final ProfileEntity profile = ProfileModel.fromJson(res);

    final Map<String, dynamic> response = await supabase
        .from('user_preferences')
        .insert(OnboardingModel.fromEntity(onboard).toJson())
        .select()
        .single();
    return OnboardingModel.fromJson(response, profile);
  }

  @override
  Future<JsonList> generateMealAI(OnboardingEntity onboard) async {
    final onboarding = OnboardingModel.fromEntity(onboard);
    final responseFromAI = await gemini.generateMealAI(onboarding);
    return JsonList.from(jsonDecode(responseFromAI ?? ''));
  }

  @override
  Future<void> saveGeneratedPlan(JsonList jsonList) async {
    final res = await supabase
        .from('meal_plan')
        .insert({'user_id': user.id, 'plan_start': DateTime.now().toString()})
        .select()
        .single();

    final String mealPlanId = res['id'];

    final daysPayload = jsonList.map((day) {
      return {
        'meal_plan_id': mealPlanId,
        'day': Weekday.values.byName(day['day'].toString().toLowerCase()).value,
        'meal': day['meals'],
      };
    }).toList();

    await supabase.from('meal_plan_days').insert(daysPayload);
  }
}
