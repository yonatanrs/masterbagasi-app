import '../../entity/product/product.dart';
import '../../entity/product/productbrand/product_brand.dart';
import '../../entity/product/productcategory/product_category.dart';
import '../../entity/province/province.dart';
import '../provincedummy/province_dummy.dart';
import 'product_brand_dummy.dart';
import 'product_category_dummy.dart';
import 'product_certification_dummy.dart';

class ProductDummy {
  ProductBrandDummy productBrandDummy;
  ProductCategoryDummy productCategoryDummy;
  ProvinceDummy provinceDummy;
  ProductCertificationDummy productCertificationDummy;

  ProductDummy({
    required this.productBrandDummy,
    required this.productCategoryDummy,
    required this.provinceDummy,
    required this.productCertificationDummy,
  });

  Product generateShimmerDummy() {
    return Product(
      id: "",
      userId: "",
      productBrandId: "",
      productCategoryId: "",
      provinceId: "",
      name: "",
      slug: "",
      description: "",
      price: 0.0,
      discountPrice: 0.0,
      rating: 0.0,
      imageUrl: "",
      productBrand: productBrandDummy.generateShimmerDummy(),
      productCategory: productCategoryDummy.generateShimmerDummy(),
      province: provinceDummy.generateShimmerDummy(),
      productCertificationList: [productCertificationDummy.generateShimmerDummy()],
    );
  }

  Product generateDefaultDummy() {
    ProductBrand productBrand = productBrandDummy.generateShimmerDummy();
    ProductCategory productCategory = productCategoryDummy.generateShimmerDummy();
    Province province = provinceDummy.generateShimmerDummy();
    return Product(
      id: "1",
      userId: "1",
      productBrandId: productBrand.id,
      productCategoryId: productCategory.id,
      provinceId: province.id,
      name: "Product Sample",
      slug: "product-sample",
      description: "This is product sample",
      price: 100000,
      discountPrice: null,
      rating: 5.0,
      imageUrl: "",
      productBrand: productBrandDummy.generateShimmerDummy(),
      productCategory: productCategoryDummy.generateShimmerDummy(),
      province: provinceDummy.generateShimmerDummy(),
      productCertificationList: [productCertificationDummy.generateShimmerDummy()],
    );
  }
}