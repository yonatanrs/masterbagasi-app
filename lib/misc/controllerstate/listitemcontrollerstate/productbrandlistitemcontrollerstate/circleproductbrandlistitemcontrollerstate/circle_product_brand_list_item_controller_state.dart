import '../../../../../domain/entity/product/productbrand/product_brand.dart';
import '../../list_item_controller_state.dart';

abstract class CircleProductBrandListItemControllerState extends ListItemControllerState {
  ProductBrand productBrand;

  CircleProductBrandListItemControllerState({
    required this.productBrand
  });
}