import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BootstrapSource {
  bool isUserAuthenticated();

  Future<bool> isOnboardingCompleted();
}

class SupabaseBSource implements BootstrapSource {
  final SupabaseClient supabase;

  const SupabaseBSource(this.supabase);

  @override
  bool isUserAuthenticated() {
    final Session? session = supabase.auth.currentSession;
    final String? userId = session?.user.id;
    if (userId != null) return true;
    return false;
  }

  @override
  Future<bool> isOnboardingCompleted() async {
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
