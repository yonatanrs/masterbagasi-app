import 'package:flutter/material.dart';

import '../../../domain/entity/product/productbrand/product_brand.dart';
import '../modified_shimmer.dart';
import 'product_brand_item.dart';

class VerticalProductBrandItem extends ProductBrandItem {
  @override
  double? get itemWidth => 180.0;

  const VerticalProductBrandItem({
    Key? key,
    required ProductBrand productBrand
  }) : super(key: key, productBrand: productBrand);
}

class ShimmerVerticalProductBrandItem extends VerticalProductBrandItem {
  const ShimmerVerticalProductBrandItem({
    Key? key,
    required ProductBrand productBrand
  }) : super(key: key, productBrand: productBrand);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ModifiedShimmer.fromColors(
        child: super.build(context)
      ),
    );
  }
}