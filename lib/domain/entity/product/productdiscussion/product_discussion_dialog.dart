import '../../user/user.dart';

class ProductDiscussionDialog {
  String id;
  String discussion;
  DateTime discussionDate;
  User user;

  ProductDiscussionDialog({
    required this.id,
    required this.discussion,
    required this.discussionDate,
    required this.user
  });
}