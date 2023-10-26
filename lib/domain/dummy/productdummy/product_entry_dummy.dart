import '../../entity/product/productentry/product_entry.dart';
import 'product_dummy.dart';

class ProductEntryDummy {
  ProductDummy productDummy;

  ProductEntryDummy({
    required this.productDummy
  });

  ProductEntry generateShimmerDummy() {
    return ProductEntry(
      id: "",
      productId: "",
      productEntryId: "",
      sku: "",
      sustension: "",
      weight: 1.0,
      isViral: 0,
      isKitchen: 0,
      isHandycrafts: 0,
      isFashionable: 0,
      purchasePrice: 0,
      sellingPrice: 0,
      isBestSelling: 0,
      productVariantList: [],
      imageUrlList: [],
      product: productDummy.generateShimmerDummy(),
      soldCount: 0,
      hasAddedToWishlist: false
    );
  }

  ProductEntry generateDefaultDummy() {
    return ProductEntry(
      id: "1",
      productId: "1",
      productEntryId: "1",
      sku: "1",
      sustension: "1",
      weight: 1.0,
      isViral: 0,
      isKitchen: 0,
      isHandycrafts: 0,
      isFashionable: 0,
      purchasePrice: 0,
      sellingPrice: 100000,
      isBestSelling: 0,
      productVariantList: [],
      imageUrlList: [],
      product: productDummy.generateDefaultDummy(),
      soldCount: 0,
      hasAddedToWishlist: false
    );
  }
}