import 'package:flutter/material.dart';

import '../../../domain/entity/product/productcategory/product_category.dart';
import 'product_category_item.dart';

class HorizontalProductCategoryItem extends ProductCategoryItem {
  @override
  double? get itemWidth => 180.0;

  const HorizontalProductCategoryItem({
    Key? key,
    required ProductCategory productCategory
  }) : super(key: key, productCategory: productCategory);
}