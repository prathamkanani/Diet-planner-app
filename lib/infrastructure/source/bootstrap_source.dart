import 'package:supabase_flutter/supabase_flutter.dart';
import '../../application/service/app_data_service.dart';
import '../app_injector.dart';

abstract interface class BootstrapSource {
  bool fetchAuthStatus();

  Future<bool> fetchOnboardingStatus();
}

class SupabaseBSource implements BootstrapSource {
  final SupabaseClient supabase;
  final AppDataService appDataService = locator.get();

  SupabaseBSource(this.supabase);

  @override
  bool fetchAuthStatus() {
    final Session? session = supabase.auth.currentSession;
    final String? userId = session?.user.id;
    appDataService.userId = userId;
    if (userId != null) return true;
    return false;
  }

  @override
  Future<bool> fetchOnboardingStatus() async {
    final User? user = supabase.auth.currentUser;
    final String id = user!.id;
    final Map<String, dynamic>? res = await supabase
        .from('meal_plan')
        .select()
        .eq('user_id', id)
        .maybeSingle();
    return (res != null);
  }
}
