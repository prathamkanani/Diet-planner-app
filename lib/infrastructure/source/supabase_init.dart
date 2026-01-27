import 'package:supabase_flutter/supabase_flutter.dart';
import '../../env.dart';

/// Initializing the supabase.
class SupabaseConfig {
  static Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
      authOptions: const FlutterAuthClientOptions(

        // Auto refresh token before expiry
        autoRefreshToken: true,

        // Removes user session as soon as
        // app closes or restarts/reloads.
        localStorage: EmptyLocalStorage(),
      ),
    );
  }
}