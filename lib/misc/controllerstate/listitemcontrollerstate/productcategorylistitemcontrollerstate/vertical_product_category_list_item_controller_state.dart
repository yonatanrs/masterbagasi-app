import '../../../../domain/entity/product/productcategory/product_category.dart';
import 'product_category_list_item_controller_state.dart';

class VerticalProductCategoryListItemControllerState extends ProductCategoryListItemControllerState {
  VerticalProductCategoryListItemControllerState({
    required ProductCategory productCategory
  }) : super(productCategory: productCategory);
}

class ShimmerVerticalProductCategoryListItemControllerState extends VerticalProductCategoryListItemControllerState {
  ShimmerVerticalProductCategoryListItemControllerState({
    required ProductCategory productCategory
  }) : super(productCategory: productCategory);
}