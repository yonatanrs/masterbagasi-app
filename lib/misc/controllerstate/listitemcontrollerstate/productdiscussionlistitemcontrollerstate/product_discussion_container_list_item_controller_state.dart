import '../../../../domain/entity/product/productdiscussion/product_discussion_dialog.dart';
import '../../../../domain/entity/product/productdiscussion/product_discussion_dialog_paging_parameter.dart';
import '../../../load_data_result.dart';
import '../../../paging/pagingresult/paging_data_result.dart';
import '../list_item_controller_state.dart';
import 'product_discussion_list_item_controller_state.dart';

class ProductDiscussionContainerListItemControllerState extends ListItemControllerState {
  List<ProductDiscussionListItemValue> productDiscussionListItemValueList;
  void Function() onUpdateState;
  ProductDiscussionListItemValueStorage productDiscussionListItemValueStorage;
  ProductDiscussionContainerActionListItemControllerState productDiscussionContainerActionListItemControllerState;

  ProductDiscussionContainerListItemControllerState({
    required this.productDiscussionListItemValueList,
    required this.onUpdateState,
    required this.productDiscussionListItemValueStorage,
    required this.productDiscussionContainerActionListItemControllerState
  });
}

abstract class ProductDiscussionContainerActionListItemControllerState extends ListItemControllerState {
  Future<LoadDataResult<PagingDataResult<ProductDiscussionDialog>>> Function(ProductDiscussionDialogPagingParameter) get getProductDiscussionDialogPaging;
}