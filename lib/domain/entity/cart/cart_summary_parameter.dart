import '../additionalitem/additional_item.dart';
import '../address/address.dart';
import 'cart.dart';

class CartSummaryParameter {
  String? couponId;
  Address? address;
  List<Cart> cartList;
  List<AdditionalItem> additionalItemList;

  CartSummaryParameter({
    required this.cartList,
    required this.additionalItemList,
    required this.couponId,
    required this.address
  });
}