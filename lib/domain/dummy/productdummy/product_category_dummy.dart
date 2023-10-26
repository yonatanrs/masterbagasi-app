import '../../entity/product/productcategory/product_category.dart';

class ProductCategoryDummy {
  ProductCategoryDummy();

  ProductCategory generateShimmerDummy() {
    return ProductCategory(
      id: "",
      name: "",
      slug: "",
      icon: "",
      bannerDesktop: "",
      bannerMobile: ""
    );
  }

  ProductCategory generateDefaultDummy() {
    return ProductCategory(
      id: "1",
      name: "Product Brand Sample",
      slug: "product-brand-slug",
      icon: null,
      bannerDesktop: null,
      bannerMobile: null
    );
  }
}