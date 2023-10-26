import '../../../../domain/entity/product/productcategory/product_category.dart';
import '../list_item_controller_state.dart';

abstract class ProductCategoryListItemControllerState extends ListItemControllerState {
  ProductCategory productCategory;

  ProductCategoryListItemControllerState({
    required this.productCategory
  });
}