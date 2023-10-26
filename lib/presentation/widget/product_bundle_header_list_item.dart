import 'package:flutter/material.dart';

import '../../domain/entity/product/productbundle/product_bundle.dart';
import 'product_bundle_highlight_list_item.dart';

class ProductBundleHeaderListItem extends StatelessWidget {
  final ProductBundle productBundle;

  const ProductBundleHeaderListItem({super.key, required this.productBundle});

  @override
  Widget build(BuildContext context) {
    return ProductBundleHighlightListItem(
      productBundle: productBundle
    );
  }
}