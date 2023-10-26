import '../../../domain/entity/product/productbundle/product_bundle.dart';
import '../../../presentation/widget/productbundle/product_bundle_item.dart';
import 'list_item_controller_state.dart';

class ProductBundleHighlightListItemControllerState extends ListItemControllerState {
  ProductBundle productBundle;
  OnAddWishlistWithProductBundle? onAddWishlist;
  OnRemoveWishlistWithProductBundle? onRemoveWishlist;
  OnAddWishlistWithProductBundle? onAddCart;
  OnRemoveWishlistWithProductBundle? onRemoveCart;

  ProductBundleHighlightListItemControllerState({
    required this.productBundle,
    this.onAddWishlist,
    this.onRemoveWishlist,
    this.onAddCart,
    this.onRemoveCart
  });
}