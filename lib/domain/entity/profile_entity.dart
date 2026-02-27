enum Gender { male, female }

/// Represents basic user information
class ProfileEntity {
  /// Unique user ID.
  final String userId;

  /// Unique profile ID.
  final String? profileId;

  /// User avatar URL.
  final String? avatarUrl;

  /// Full name of the user.
  final String? fullName;

  /// Email of the user.
  final String? email;

  /// Mobile Number of the user.
  final String? mobileNumber;

  /// Weight of the user.
  final double? weight;

  /// Height of the user.
  final double? height;

  /// Gender of the user.
  final Gender? gender;

  /// Age of the user.
  final int? age;

  /// Created an immutable instance of [ProfileEntity].
  ProfileEntity({
    required this.userId,
    this.profileId,
    this.avatarUrl,
    this.fullName,
    this.email,
    this.mobileNumber,
    this.weight,
    this.height,
    this.gender,
    this.age,
  });

  static ProfileEntity empty() => ProfileEntity(userId: '');

  @override
  bool operator ==(Object other) {
    return other is ProfileEntity &&
        other.userId == userId &&
        other.fullName == fullName &&
        other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.age == age &&
        other.gender == gender &&
        other.height == height &&
        other.weight == weight &&
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode => Object.hash(
    userId,
    fullName,
    email,
    mobileNumber,
    age,
    gender,
    height,
    weight,
    avatarUrl,
  );
}
