import '../../../../../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../../list_item_controller_state.dart';

abstract class ProductDiscussionDialogListItemControllerState extends ListItemControllerState {
  ProductDiscussionDialog productDiscussionDialog;
  bool isMainProductDiscussion;

  ProductDiscussionDialogListItemControllerState({
    required this.productDiscussionDialog,
    required this.isMainProductDiscussion
  });
}