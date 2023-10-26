import '../additionalitem/additional_item.dart';
import '../address/address.dart';
import 'order_detail.dart';
import 'order_product_detail.dart';

class OrderProduct {
  String id;
  String orderId;
  String userAddressId;
  OrderDetail orderDetail;
  Address? userAddress;
  List<OrderProductDetail> orderProductDetailList;
  List<AdditionalItem> additionalItemList;

  OrderProduct({
    required this.id,
    required this.orderId,
    required this.userAddressId,
    required this.orderDetail,
    required this.userAddress,
    required this.orderProductDetailList,
    required this.additionalItemList
  });
}