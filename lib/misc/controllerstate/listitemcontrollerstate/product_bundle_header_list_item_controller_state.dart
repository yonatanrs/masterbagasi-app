import '../../../domain/entity/product/productbundle/product_bundle.dart';
import 'list_item_controller_state.dart';

class ProductBundleHeaderListItemControllerState extends ListItemControllerState {
  ProductBundle productBundle;

  ProductBundleHeaderListItemControllerState({
    required this.productBundle
  });
}