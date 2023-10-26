import 'package:flutter/material.dart';

import '../../../domain/entity/product/productbrand/product_brand.dart';
import 'product_brand_item.dart';

class HorizontalProductBrandItem extends ProductBrandItem {
  @override
  double? get itemWidth => 180.0;

  const HorizontalProductBrandItem({
    Key? key,
    required ProductBrand productBrand
  }) : super(key: key, productBrand: productBrand);
}