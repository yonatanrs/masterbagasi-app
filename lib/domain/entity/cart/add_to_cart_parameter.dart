import 'support_cart.dart';

class AddToCartParameter {
  SupportCart supportCart;
  int quantity;

  AddToCartParameter({
    required this.supportCart,
    required this.quantity
  });
}