import 'short_cart_list_item_controller_state.dart';

class VerticalShortCartListItemControllerState extends ShortCartListItemControllerState {
  VerticalShortCartListItemControllerState({
    required super.cart,
    super.onSelectCart
  });
}

class ShimmerVerticalShortCartListItemControllerState extends VerticalShortCartListItemControllerState {
  ShimmerVerticalShortCartListItemControllerState({
    required super.cart,
  });
}