import '../../../domain/entity/product/productbrand/product_brand.dart';
import 'list_item_controller_state.dart';

class ProductDetailBrandListItemControllerState extends ListItemControllerState {
  ProductBrand productBrand;
  void Function(ProductBrand)? onTapProductBrand;
  void Function(ProductBrand)? onAddToFavoriteProductBrand;
  void Function(ProductBrand)? onRemoveFromFavoriteProductBrand;

  ProductDetailBrandListItemControllerState({
    required this.productBrand,
    this.onTapProductBrand,
    this.onAddToFavoriteProductBrand,
    this.onRemoveFromFavoriteProductBrand
  });
}