import 'productbundle/product_bundle_item.dart';

class ProductBundleHighlightListItem extends ProductBundleItem {
  const ProductBundleHighlightListItem({
    super.key,
    required super.productBundle,
    super.onAddWishlist,
    super.onRemoveWishlist,
    super.onAddCart,
    super.onRemoveCart
  });
}