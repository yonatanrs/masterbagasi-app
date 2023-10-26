import '../../../../domain/entity/product/productbrand/product_brand.dart';
import '../support_vertical_grid_list_item_controller_state.dart';
import 'product_brand_list_item_controller_state.dart';

class VerticalProductBrandListItemControllerState extends ProductBrandListItemControllerState with SupportVerticalGridListItemControllerStateMixin {
  VerticalProductBrandListItemControllerState({
    required ProductBrand productBrand
  }) : super(productBrand: productBrand);
}

class ShimmerVerticalProductBrandListItemControllerState extends VerticalProductBrandListItemControllerState {
  ShimmerVerticalProductBrandListItemControllerState({
    required ProductBrand productBrand
  }) : super(productBrand: productBrand);
}