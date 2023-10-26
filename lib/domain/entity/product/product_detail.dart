import 'product.dart';
import 'productentry/product_entry.dart';

class ProductDetail extends Product {
  List<ProductEntry> productEntry;

  ProductDetail({
    required super.id,
    required super.userId,
    required super.productBrandId,
    required super.productCategoryId,
    required super.provinceId,
    required super.name,
    required super.slug,
    required super.description,
    required super.price,
    required super.discountPrice,
    required super.rating,
    required super.imageUrl,
    required super.productBrand,
    required super.productCategory,
    required super.province,
    required super.productCertificationList,
    required this.productEntry
  });
}