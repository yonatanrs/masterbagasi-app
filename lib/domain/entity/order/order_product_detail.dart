import 'support_order_product.dart';

class OrderProductDetail {
  String id;
  String orderProductId;
  SupportOrderProduct supportOrderProduct;
  int quantity;
  String? notes;

  OrderProductDetail({
    required this.id,
    required this.orderProductId,
    required this.supportOrderProduct,
    required this.quantity,
    required this.notes
  });
}