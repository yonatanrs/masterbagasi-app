import 'order_item.dart';

class VerticalOrderItem extends OrderItem {
  const VerticalOrderItem({
    super.key,
    required super.order
  });

  @override
  double? get itemWidth => null;
}