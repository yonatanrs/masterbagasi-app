import '../domain/entity/product/productentry/product_entry.dart';

class _ProductHelperImpl {
  ProductEntry? getSelectedProductEntry(List<ProductEntry> productEntryList, int productEntryIndex) {
    ProductEntry? selectedProductEntry;
    if (productEntryList.isNotEmpty && productEntryIndex > -1) {
      selectedProductEntry = productEntryList[productEntryIndex];
    } else if (productEntryIndex == -1) {
      selectedProductEntry = productEntryList.first;
    }
    return selectedProductEntry;
  }
}

// ignore: non_constant_identifier_names
final _ProductHelperImpl ProductHelper = _ProductHelperImpl();