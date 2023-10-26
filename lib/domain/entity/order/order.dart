import 'combined_order.dart';
import 'order_summary.dart';

class Order {
  OrderSummary orderSummary;
  CombinedOrder combinedOrder;

  Order({
    required this.orderSummary,
    required this.combinedOrder
  });
}