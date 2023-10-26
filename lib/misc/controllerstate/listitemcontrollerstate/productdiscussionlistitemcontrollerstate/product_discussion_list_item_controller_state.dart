import '../../../../domain/entity/product/productdiscussion/product_discussion.dart';
import '../list_item_controller_state.dart';

abstract class ProductDiscussionListItemControllerState extends ListItemControllerState {
  ProductDiscussion productDiscussion;
  bool isExpanded;
  void Function(ProductDiscussion)? onProductDiscussionTap;

  ProductDiscussionListItemControllerState({
    required this.productDiscussion,
    required this.isExpanded,
    this.onProductDiscussionTap
  });
}

class ProductDiscussionListItemValue {
  ProductDiscussion productDiscussion;
  bool isExpanded;

  ProductDiscussionListItemValue({
    required this.productDiscussion,
    required this.isExpanded
  });
}

abstract class ProductDiscussionListItemValueStorage {}