import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entity/gender_enum.dart';
import '../../domain/entity/profile_entity.dart';

/// Data-Transfer Object for the profile entity.
class ProfileModel extends ProfileEntity {
  /// Creates an immutable [ProfileEntity]
  ProfileModel({
    required super.userId,
    super.profileId,
    super.avatarUrl,
    super.fullName,
    super.email,
    super.mobileNumber,
    super.height,
    super.weight,
    super.gender,
    super.age,
  });

  factory ProfileModel.fromUserDetails({
    required String userId,
    required String name,
    required Gender gender,
    required String age,
    required String height,
    required String weight,
  }) {
    return ProfileModel(
      userId: userId,
      fullName: name,
      gender: gender,
      age: int.tryParse(age),
      height: double.tryParse(height),
      weight: double.tryParse(weight)
    );
  }

  ProfileModel.fromAvatar({required String userId, required String avatar})
    : this(userId: userId, avatarUrl: avatar);

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      userId: entity.userId,
      avatarUrl: entity.avatarUrl,
      fullName: entity.fullName,
      email: entity.email,
      mobileNumber: entity.mobileNumber,
    );
  }

  /// Creates Profile DTO from Json(from database)
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['user_id'] as String,
      avatarUrl: json['avatar_url'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobile_number'] as String?,
    );
  }

  factory ProfileModel.fromSupabaseUserAndEntity(
    User user,
    ProfileEntity? profile,
    String seed,
  ) {
    return ProfileModel(
      userId: user.id,
      avatarUrl: seed,
      fullName: user.userMetadata?['full_name'],
      email: user.email,
      mobileNumber: user.phone,
      height: profile?.height,
      weight: profile?.weight,
      gender: profile?.gender,
      age: profile?.age,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'avatar_url': avatarUrl,
      'full_name': fullName,
      'email': email,
      'mobile_number': mobileNumber,
      'height': height,
      'weight': weight,
      'gender': gender,
      'age': age,
    };
  }
}
