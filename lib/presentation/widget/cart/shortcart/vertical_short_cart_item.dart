import 'package:flutter/material.dart';

import '../../modified_shimmer.dart';
import 'short_cart_item.dart';

class VerticalShortCartItem extends ShortCartItem {
  @override
  double? get itemWidth => null;

  @override
  double? get itemHeight => null;

  const VerticalShortCartItem({
    super.key,
    required super.cart,
    super.onSelectCart
  });
}

class ShimmerVerticalShortCartItem extends VerticalShortCartItem {
  const ShimmerVerticalShortCartItem({
    super.key,
    required super.cart,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ModifiedShimmer.fromColors(
        child: super.build(context)
      ),
    );
  }
}