import 'support_cart.dart';

class Cart {
  String id;
  SupportCart supportCart;
  int quantity;
  String? notes;

  Cart({
    required this.id,
    required this.supportCart,
    required this.quantity,
    required this.notes
  });
}