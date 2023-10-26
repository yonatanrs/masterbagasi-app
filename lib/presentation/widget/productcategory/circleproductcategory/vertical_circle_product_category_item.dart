import 'package:flutter/material.dart';

import '../../modified_shimmer.dart';
import 'circle_product_category_item.dart';

class VerticalCircleProductCategoryItem extends CircleProductCategoryItem {
  @override
  double? get itemWidth => null;

  const VerticalCircleProductCategoryItem({
    super.key,
    required super.productCategory
  });
}

class ShimmerVerticalCircleProductCategoryItem extends VerticalCircleProductCategoryItem {
  const ShimmerVerticalCircleProductCategoryItem({
    super.key,
    required super.productCategory
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