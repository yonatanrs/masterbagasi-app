import '../../entity/product/productbrand/product_brand.dart';

class ProductBrandDummy {
  ProductBrandDummy();

  ProductBrand generateShimmerDummy() {
    return ProductBrand(
      id: "",
      name: "",
      slug: "",
      icon: "",
      bannerDesktop: "",
      bannerMobile: ""
    );
  }

  ProductBrand generateDefaultDummy() {
    return ProductBrand(
      id: "1",
      name: "Product Brand Sample",
      slug: "product-brand-slug",
      icon: null,
      bannerDesktop: null,
      bannerMobile: null
    );
  }
}