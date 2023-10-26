class User {
  String id;
  String name;
  int role;
  String email;
  UserProfile userProfile;
  DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.userProfile,
    required this.createdAt
  });
}

class UserProfile {
  String id;
  String userId;
  String? avatar;
  String? gender;
  DateTime? dateBirth;
  String? placeBirth;
  String? phoneNumber;

  UserProfile({
    required this.id,
    required this.userId,
    required this.avatar,
    required this.gender,
    required this.dateBirth,
    required this.placeBirth,
    required this.phoneNumber,
  });
}