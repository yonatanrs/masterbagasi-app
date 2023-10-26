import '../additionalitem/additional_item.dart';
import '../address/address.dart';
import 'order_product_detail.dart';

class OrderProductInOrderShipping {
  String id;
  String orderId;
  String userAddressId;
  Address? userAddress;
  List<OrderProductDetail> orderProductDetailList;
  List<AdditionalItem> additionalItemList;

  OrderProductInOrderShipping({
    required this.id,
    required this.orderId,
    required this.userAddressId,
    required this.userAddress,
    required this.orderProductDetailList,
    required this.additionalItemList
  });
}