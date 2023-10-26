import 'package:flutter/material.dart';

import '../../../domain/entity/product/productbundle/product_bundle.dart';
import '../modified_shimmer.dart';
import 'product_bundle_item.dart';

class VerticalProductBundleItem extends ProductBundleItem {
  const VerticalProductBundleItem({
    Key? key,
    required ProductBundle productBundle,
    OnAddWishlistWithProductBundle? onAddWishlist,
    OnRemoveWishlistWithProductBundle? onRemoveWishlist,
    OnAddCartWithProductBundle? onAddCart,
    OnRemoveCartWithProductBundle? onRemoveCart
  }) : super(
    key: key,
    productBundle: productBundle,
    onAddWishlist: onAddWishlist,
    onRemoveWishlist: onRemoveWishlist,
    onAddCart: onAddCart,
    onRemoveCart: onRemoveCart
  );
}

class ShimmerVerticalProductBundleItem extends VerticalProductBundleItem {
  const ShimmerVerticalProductBundleItem({
    Key? key,
    required ProductBundle productBundle
  }) : super(key: key, productBundle: productBundle);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ModifiedShimmer.fromColors(
        child: super.build(context)
      ),
    );
  }
}