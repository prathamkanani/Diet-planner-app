import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entity/onboarding_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../model/onboarding_model.dart';
import '../model/profile_model.dart';
import '../service/gemini_client_service.dart';

abstract interface class OnboardingSource {
  Future<OnboardingEntity> saveOnboardingDetails(OnboardingEntity onboard);

  Future<String?> generateMealAI(OnboardingEntity onboard);
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
    final Map<String, dynamic> res = await supabase
        .from('profiles')
        .insert(ProfileModel.fromEntity(onboard.profileEntity).toJson())
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
  Future<String?> generateMealAI(OnboardingEntity onboard) async {
    final onboarding = OnboardingModel.fromEntity(onboard);
    return gemini.generateMealAI(onboarding);
  }
}
