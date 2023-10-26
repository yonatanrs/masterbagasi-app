import '../coupon/coupon.dart';
import '../user/user.dart';
import 'order_product.dart';
import 'order_shipping.dart';

class CombinedOrder {
  String id;
  String userId;
  String orderProductId;
  String? orderShippingId;
  String orderCode;
  String? couponId;
  String? picId;
  String? picTakeoverId;
  String status;
  DateTime? takeoverAt;
  int review;
  Coupon? coupon;
  User user;
  OrderProduct orderProduct;
  OrderShipping? orderShipping;
  DateTime createdAt;

  CombinedOrder({
    required this.id,
    required this.userId,
    required this.orderProductId,
    required this.orderShippingId,
    required this.orderCode,
    required this.couponId,
    this.picId,
    this.picTakeoverId,
    required this.status,
    this.takeoverAt,
    required this.review,
    this.coupon,
    required this.user,
    required this.orderProduct,
    required this.orderShipping,
    required this.createdAt
  });
}