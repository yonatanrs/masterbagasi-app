class UserNotification {
  String id;
  String name;
  int role;
  String email;
  DateTime? createdAt;

  UserNotification({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.createdAt
  });
}