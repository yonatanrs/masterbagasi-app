import 'package:flutter/material.dart';

import '../../../domain/entity/product/productcategory/product_category.dart';
import '../modified_shimmer.dart';
import 'product_category_item.dart';

class VerticalProductCategoryItem extends ProductCategoryItem {
  @override
  double? get itemWidth => null;

  const VerticalProductCategoryItem({
    Key? key,
    required ProductCategory productCategory
  }) : super(key: key, productCategory: productCategory);
}

class ShimmerVerticalProductCategoryItem extends VerticalProductCategoryItem {
  const ShimmerVerticalProductCategoryItem({
    Key? key,
    required ProductCategory productCategory
  }) : super(key: key, productCategory: productCategory);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ModifiedShimmer.fromColors(
        child: super.build(context)
      ),
    );
  }
}