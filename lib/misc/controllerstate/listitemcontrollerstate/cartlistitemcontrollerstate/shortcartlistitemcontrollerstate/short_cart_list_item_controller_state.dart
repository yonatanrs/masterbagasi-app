import '../../../../../domain/entity/cart/cart.dart';
import '../../../../../presentation/widget/cart/shortcart/short_cart_item.dart';
import '../../list_item_controller_state.dart';

abstract class ShortCartListItemControllerState extends ListItemControllerState {
  Cart cart;
  OnSelectCart? onSelectCart;

  ShortCartListItemControllerState({
    required this.cart,
    this.onSelectCart
  });
}