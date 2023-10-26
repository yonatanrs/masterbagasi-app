import 'order_detail.dart';
import 'order_product_in_order_shipping.dart';

class OrderShipping {
  String id;
  String orderId;
  String orderProductId;
  String trackingNumber;
  String status;
  String? notes;
  OrderDetail orderDetail;
  OrderProductInOrderShipping orderProductInOrderShipping;

  OrderShipping({
    required this.id,
    required this.orderId,
    required this.orderProductId,
    required this.trackingNumber,
    required this.status,
    this.notes,
    required this.orderDetail,
    required this.orderProductInOrderShipping
  });
}