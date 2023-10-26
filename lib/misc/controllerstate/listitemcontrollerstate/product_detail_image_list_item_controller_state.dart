import '../../../domain/entity/product/product_appearance_data.dart';
import '../../../domain/entity/product/productentry/product_entry.dart';
import 'list_item_controller_state.dart';

class ProductDetailImageListItemControllerState extends ListItemControllerState {
  List<ProductEntry> productEntryList;
  int Function() onGetProductEntryIndex;

  ProductDetailImageListItemControllerState({
    required this.productEntryList,
    required this.onGetProductEntryIndex
  });
}