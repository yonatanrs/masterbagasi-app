import '../address/address.dart';

class OrderDetail {
  String id;
  String status;
  String paymentType;
  int totalPrice;
  String snapToken;
  int realTotalPrice;

  OrderDetail({
    required this.id,
    required this.status,
    required this.paymentType,
    required this.totalPrice,
    required this.snapToken,
    required this.realTotalPrice
  });
}