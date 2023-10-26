import '../../../../domain/entity/product/productbundle/product_bundle.dart';
import '../../../../presentation/widget/productbundle/product_bundle_item.dart';
import '../list_item_controller_state.dart';

class ProductBundleHeaderListItemControllerState extends ListItemControllerState {
  ProductBundle productBundle;
  OnAddWishlistWithProductBundle? onAddWishlist;
  OnRemoveWishlistWithProductBundle? onRemoveWishlist;

  ProductBundleHeaderListItemControllerState({
    required this.productBundle,
    required this.onAddWishlist,
    required this.onRemoveWishlist
  });
}