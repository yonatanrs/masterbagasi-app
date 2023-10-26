import 'product_discussion_dialog.dart';

class ProductDiscussion {
  String id;
  String title;
  String? imageUrl;
  ProductDiscussionDialog productDiscussionDialog;
  int discussionCount;

  ProductDiscussion({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.productDiscussionDialog,
    required this.discussionCount
  });
}