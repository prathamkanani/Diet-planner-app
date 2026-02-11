import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entity/profile_entity.dart';
import '../model/profile_model.dart';

/// Defines contracts of Profile for a source.
abstract interface class ProfileSource {
  Future<void> saveProfile(ProfileEntity userProfile, String seed);

  Future<void> editProfile(ProfileEntity userProfile);

  Future<ProfileEntity> getUserProfile(String userId);
}

class ProfileRemoteDataSource implements ProfileSource {
  final SupabaseClient supabase;

  ProfileRemoteDataSource(this.supabase);

  late final User user = supabase.auth.currentUser!;

  /// Saves the profile into the supabase profile table.
  @override
  Future<void> saveProfile(ProfileEntity userProfile, String seed) async {
    await supabase
        .from('profiles')
        .update(ProfileModel.fromEntity(userProfile).toJson())
        .eq('user_id', user.id);
  }

  /// Gets the profile from the profile table.
  @override
  Future<ProfileEntity> getUserProfile(String userId) async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('user_id', userId)
        .single();
    return ProfileModel.fromJson(response);
  }

  /// Update the data to profile table.
  @override
  Future<void> editProfile(ProfileEntity userProfile) async {
    await supabase
        .from('profiles')
        .update(ProfileModel.fromEntity(userProfile).toJson());
  }
}
