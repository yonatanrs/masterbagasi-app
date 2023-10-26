import '../../../../domain/entity/product/product_appearance_data.dart';
import '../../../../presentation/widget/product/product_item.dart';
import '../support_vertical_grid_list_item_controller_state.dart';
import 'product_list_item_controller_state.dart';

class VerticalProductListItemControllerState extends ProductListItemControllerState with SupportVerticalGridListItemControllerStateMixin {
  VerticalProductListItemControllerState({
    required ProductAppearanceData productAppearanceData,
    OnAddWishlistWithProductAppearanceData? onAddWishlist,
    OnRemoveWishlistWithProductAppearanceData? onRemoveWishlist,
    OnAddCartWithProductAppearanceData? onAddCart,
    OnRemoveCartWithProductAppearanceData? onRemoveCart
  }) : super(
    productAppearanceData: productAppearanceData,
    onAddWishlist: onAddWishlist,
    onRemoveWishlist: onRemoveWishlist,
    onAddCart: onAddCart,
    onRemoveCart: onRemoveCart
  );
}

class ShimmerVerticalProductListItemControllerState extends VerticalProductListItemControllerState {
  ShimmerVerticalProductListItemControllerState({
    required ProductAppearanceData productAppearanceData
  }) : super(productAppearanceData: productAppearanceData);
}