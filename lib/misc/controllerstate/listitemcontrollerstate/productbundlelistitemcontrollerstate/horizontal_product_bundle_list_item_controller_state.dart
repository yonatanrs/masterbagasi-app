import '../../../../domain/entity/product/productbundle/product_bundle.dart';
import '../../../../presentation/widget/productbundle/product_bundle_item.dart';
import 'product_bundle_list_item_controller_state.dart';

class HorizontalProductBundleListItemControllerState extends ProductBundleListItemControllerState {
  HorizontalProductBundleListItemControllerState({
    required ProductBundle productBundle,
    OnAddWishlistWithProductBundle? onAddWishlist,
    OnRemoveWishlistWithProductBundle? onRemoveWishlist,
    OnAddCartWithProductBundle? onAddCart,
    OnRemoveCartWithProductBundle? onRemoveCart
  }) : super(
    productBundle: productBundle,
    onAddWishlist: onAddWishlist,
    onRemoveWishlist: onRemoveWishlist,
    onAddCart: onAddCart,
    onRemoveCart: onRemoveCart
  );
}