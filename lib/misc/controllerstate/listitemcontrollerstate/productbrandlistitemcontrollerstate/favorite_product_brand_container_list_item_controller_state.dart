import '../../../../domain/entity/product/productbrand/product_brand.dart';
import '../list_item_controller_state.dart';

class FavoriteProductBrandContainerListItemControllerState extends ListItemControllerState {
  List<ProductBrand> productBrandList;
  void Function(ProductBrand)? onTapProductBrand;
  void Function(ProductBrand) onRemoveFromFavoriteProductBrand;

  FavoriteProductBrandContainerListItemControllerState({
    required this.productBrandList,
    this.onTapProductBrand,
    required this.onRemoveFromFavoriteProductBrand
  });
}