import '../province/province.dart';
import 'product_appearance_data.dart';
import 'productbrand/product_brand.dart';
import 'productcategory/product_category.dart';
import 'productcertification/product_certification.dart';

class Product implements ProductAppearanceData {
  String id;
  String userId;
  String productBrandId;
  String productCategoryId;
  String provinceId;
  @override
  String name;
  String slug;
  String description;
  @override
  double price;
  @override
  double? discountPrice;
  double rating;
  @override
  String imageUrl;
  ProductBrand productBrand;
  ProductCategory productCategory;
  Province? province;
  List<ProductCertification> productCertificationList;

  @override
  double get weight => 0.0;

  @override
  String get productId => id;

  Product({
    required this.id,
    required this.userId,
    required this.productBrandId,
    required this.productCategoryId,
    required this.provinceId,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.rating,
    required this.imageUrl,
    required this.productBrand,
    required this.productCategory,
    required this.province,
    required this.productCertificationList,
  });
}