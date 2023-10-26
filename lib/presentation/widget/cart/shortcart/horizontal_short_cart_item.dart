import 'short_cart_item.dart';

class HorizontalShortCartItem extends ShortCartItem {
  @override
  double? get itemWidth => 200.0;

  @override
  double? get itemHeight => 100.0;

  const HorizontalShortCartItem({
    super.key,
    required super.cart,
    super.onSelectCart
  });
}