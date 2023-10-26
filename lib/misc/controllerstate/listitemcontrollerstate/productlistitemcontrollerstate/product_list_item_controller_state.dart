import '../../../../domain/entity/product/product_appearance_data.dart';
import '../../../../presentation/widget/product/product_item.dart';
import '../list_item_controller_state.dart';

abstract class ProductListItemControllerState extends ListItemControllerState {
  ProductAppearanceData productAppearanceData;
  OnAddWishlistWithProductAppearanceData? onAddWishlist;
  OnRemoveWishlistWithProductAppearanceData? onRemoveWishlist;
  OnAddCartWithProductAppearanceData? onAddCart;
  OnRemoveCartWithProductAppearanceData? onRemoveCart;

  ProductListItemControllerState({
    required this.productAppearanceData,
    this.onAddWishlist,
    this.onRemoveWishlist,
    this.onAddCart,
    this.onRemoveCart
  });
}