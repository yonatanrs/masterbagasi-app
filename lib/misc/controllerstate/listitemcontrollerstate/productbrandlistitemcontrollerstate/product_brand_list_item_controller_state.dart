import '../../../../domain/entity/product/productbrand/product_brand.dart';
import '../list_item_controller_state.dart';

abstract class ProductBrandListItemControllerState extends ListItemControllerState {
  ProductBrand productBrand;

  ProductBrandListItemControllerState({
    required this.productBrand
  });
}