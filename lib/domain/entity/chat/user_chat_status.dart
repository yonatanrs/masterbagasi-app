class UserChatStatus {
  String id;
  String userId;
  DateTime lastSeen;
  int isTyping;

  UserChatStatus({
    required this.id,
    required this.userId,
    required this.lastSeen,
    required this.isTyping
  });
}