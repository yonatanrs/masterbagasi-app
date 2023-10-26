import '../../entity/product/productcertification/product_certification.dart';

class ProductCertificationDummy {
  ProductCertificationDummy();

  ProductCertification generateShimmerDummy() {
    return ProductCertification(
      id: "",
      productId: "",
      name: "",
    );
  }

  ProductCertification generateDefaultDummy() {
    return ProductCertification(
      id: "product-certification",
      productId: "1",
      name: "Test",
    );
  }
}