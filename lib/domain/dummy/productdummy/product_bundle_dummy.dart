import '../../entity/product/productbundle/product_bundle.dart';

class ProductBundleDummy {
  ProductBundleDummy();

  ProductBundle generateShimmerDummy() {
    return ProductBundle(
      id: "",
      name: "",
      description: "",
      slug: "",
      imageUrl: "",
      price: 0.0,
      rating: 0.0,
      soldOut: 0
    );
  }

  ProductBundle generateDefaultDummy() {
    return ProductBundle(
      id: "1",
      name: "Product Variant Sample",
      description: "Product Variant Type Sample",
      slug: "product-variant-type-sample",
      imageUrl: "",
      price: 0.0,
      rating: 0.0,
      soldOut: 0
    );
  }
}