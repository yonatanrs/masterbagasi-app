class UserChat {
  String id;
  String name;
  int role;
  String email;
  DateTime? createdAt;

  UserChat({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    this.createdAt
  });
}