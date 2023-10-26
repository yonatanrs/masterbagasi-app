import '../../../../../domain/entity/product/productcategory/product_category.dart';
import '../../list_item_controller_state.dart';

abstract class CircleProductCategoryListItemControllerState extends ListItemControllerState {
  ProductCategory productCategory;

  CircleProductCategoryListItemControllerState({
    required this.productCategory
  });
}