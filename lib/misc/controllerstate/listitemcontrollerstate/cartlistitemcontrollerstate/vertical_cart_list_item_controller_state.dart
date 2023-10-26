import 'cart_list_item_controller_state.dart';

class VerticalCartListItemControllerState extends CartListItemControllerState {
  VerticalCartListItemControllerState({
    required super.cart,
    required super.isSelected,
    super.showDefaultCart = true,
    super.showCheck = true,
    super.onChangeSelected,
    super.onAddToNotes,
    super.onAddToWishlist,
    super.onRemoveFromNotes,
    super.onRemoveCart,
    super.onChangeNotes,
    super.onChangeQuantity
  });
}

class ShimmerVerticalCartListItemControllerState extends VerticalCartListItemControllerState {
  ShimmerVerticalCartListItemControllerState({
    required super.cart,
  }) : super(
    isSelected: false
  );
}