import '../../entity/product/productvariant/product_variant.dart';

class ProductVariantDummy {
  ProductVariantDummy();

  ProductVariant generateShimmerDummy() {
    return ProductVariant(
      id: "",
      productEntryId: "",
      name: "",
      type: "",
    );
  }

  ProductVariant generateDefaultDummy() {
    return ProductVariant(
      id: "1",
      productEntryId: "1",
      name: "Product Variant Sample",
      type: "Product Variant Type Sample",
    );
  }
}