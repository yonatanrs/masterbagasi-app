import 'cart_item.dart';

class HorizontalCartItem extends CartItem {
  @override
  double? get itemWidth => 200.0;

  @override
  double? get itemHeight => 100.0;

  const HorizontalCartItem({
    super.key,
    required super.cart,
    required super.isSelected,
    super.showCheck = true,
    super.showDefaultCart = true,
    super.onChangeSelected
  });
}