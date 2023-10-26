import 'package:flutter/material.dart';

import '../../modified_shimmer.dart';
import 'circle_product_brand_item.dart';

class VerticalCircleProductBrandItem extends CircleProductBrandItem {
  @override
  double? get itemWidth => null;

  const VerticalCircleProductBrandItem({
    super.key,
    required super.productBrand
  });
}

class ShimmerVerticalCircleProductBrandItem extends VerticalCircleProductBrandItem {
  const ShimmerVerticalCircleProductBrandItem({
    super.key,
    required super.productBrand
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