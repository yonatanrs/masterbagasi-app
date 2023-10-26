import 'package:flutter/material.dart';

import '../modified_shimmer.dart';
import 'cart_item.dart';

class VerticalCartItem extends CartItem {
  @override
  double? get itemWidth => null;

  @override
  double? get itemHeight => null;

  const VerticalCartItem({
    super.key,
    required super.cart,
    required super.isSelected,
    super.showDefaultCart = true,
    super.showCheck = true,
    super.onChangeSelected,
    super.onAddToNotes,
    super.onChangeNotes,
    super.onRemoveFromNotes,
    super.onAddToWishlist,
    super.onRemoveCart,
    super.onChangeQuantity
  });
}

class ShimmerVerticalCartItem extends VerticalCartItem {
  const ShimmerVerticalCartItem({
    super.key,
    required super.cart
  }) : super(
    isSelected: false
  );

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ModifiedShimmer.fromColors(
        child: super.build(context)
      ),
    );
  }
}