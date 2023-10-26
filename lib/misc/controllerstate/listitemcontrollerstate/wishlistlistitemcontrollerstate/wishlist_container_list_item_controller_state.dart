import '../../../../domain/entity/wishlist/wishlist.dart';
import '../../../../presentation/widget/product/product_item.dart';
import '../../../../presentation/widget/productbundle/product_bundle_item.dart';
import '../list_item_controller_state.dart';

class WishlistContainerListItemControllerState extends ListItemControllerState {
  List<Wishlist> wishlistList;
  void Function() onUpdateState;
  OnRemoveWishlistWithWishlist onRemoveWishlistWithWishlist;
  OnAddCartWithProductAppearanceData onAddProductCart;
  OnAddCartWithProductBundle onAddProductBundleCart;
  WishlistContainerInterceptingActionListItemControllerState wishlistContainerInterceptingActionListItemControllerState;

  WishlistContainerListItemControllerState({
    required this.wishlistList,
    required this.onUpdateState,
    required this.onRemoveWishlistWithWishlist,
    required this.onAddProductCart,
    required this.onAddProductBundleCart,
    required this.wishlistContainerInterceptingActionListItemControllerState
  });
}

abstract class WishlistContainerInterceptingActionListItemControllerState extends ListItemControllerState {
  void Function(Wishlist)? get removeWishlist;
}