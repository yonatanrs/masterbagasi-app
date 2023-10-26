import '../../../domain/entity/product/productcategory/product_category.dart';
import 'list_item_controller_state.dart';

class ProductCategoryHeaderListItemControllerState extends ListItemControllerState {
  ProductCategory productCategory;

  ProductCategoryHeaderListItemControllerState({
    required this.productCategory
  });
}