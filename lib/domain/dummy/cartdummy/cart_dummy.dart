import '../../entity/cart/cart.dart';
import '../productdummy/product_entry_dummy.dart';

class CartDummy {
  ProductEntryDummy productEntryDummy;

  CartDummy({
    required this.productEntryDummy
  });

  Cart generateShimmerDummy() {
    return Cart(
      id: "",
      quantity: 1,
      notes: "",
      supportCart: productEntryDummy.generateShimmerDummy()
    );
  }

  Cart generateDefaultDummy() {
    return Cart(
      id: "",
      quantity: 1,
      notes: "",
      supportCart: productEntryDummy.generateDefaultDummy()
    );
  }
}