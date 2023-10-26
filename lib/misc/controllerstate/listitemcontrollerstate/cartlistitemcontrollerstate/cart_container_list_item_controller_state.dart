import '../../../../domain/entity/additionalitem/add_additional_item_parameter.dart';
import '../../../../domain/entity/additionalitem/add_additional_item_response.dart';
import '../../../../domain/entity/additionalitem/additional_item.dart';
import '../../../../domain/entity/additionalitem/additional_item_list_parameter.dart';
import '../../../../domain/entity/additionalitem/change_additional_item_parameter.dart';
import '../../../../domain/entity/additionalitem/change_additional_item_response.dart';
import '../../../../domain/entity/additionalitem/remove_additional_item_parameter.dart';
import '../../../../domain/entity/additionalitem/remove_additional_item_response.dart';
import '../../../../domain/entity/cart/cart.dart';
import '../../../load_data_result.dart';
import '../list_item_controller_state.dart';
import 'cart_list_item_controller_state.dart';

class CartContainerListItemControllerState extends ListItemControllerState {
  List<CartListItemControllerState> cartListItemControllerStateList;
  void Function() onUpdateState;
  void Function() onScrollToAdditionalItemsSection;
  void Function(List<Cart>) onChangeSelected;
  void Function() onCartChange;
  CartContainerStateStorageListItemControllerState cartContainerStateStorageListItemControllerState;
  CartContainerActionListItemControllerState cartContainerActionListItemControllerState;
  CartContainerInterceptingActionListItemControllerState cartContainerInterceptingActionListItemControllerState;
  List<AdditionalItem> additionalItemList;

  CartContainerListItemControllerState({
    required this.cartListItemControllerStateList,
    required this.onUpdateState,
    required this.onScrollToAdditionalItemsSection,
    required this.onChangeSelected,
    required this.onCartChange,
    required this.cartContainerStateStorageListItemControllerState,
    required this.cartContainerActionListItemControllerState,
    required this.cartContainerInterceptingActionListItemControllerState,
    required this.additionalItemList
  });
}

abstract class CartContainerStateStorageListItemControllerState extends ListItemControllerState {}

abstract class CartContainerActionListItemControllerState extends ListItemControllerState {
  Future<LoadDataResult<List<AdditionalItem>>> Function(AdditionalItemListParameter) get getAdditionalItemList;
  Future<LoadDataResult<AddAdditionalItemResponse>> Function(AddAdditionalItemParameter) get addAdditionalItem;
  Future<LoadDataResult<ChangeAdditionalItemResponse>> Function(ChangeAdditionalItemParameter) get changeAdditionalItem;
  Future<LoadDataResult<RemoveAdditionalItemResponse>> Function(RemoveAdditionalItemParameter) get removeAdditionalItem;
}

abstract class CartContainerInterceptingActionListItemControllerState extends ListItemControllerState {
  void Function(Cart)? get removeCart;
  int Function()? get getCartCount;
}