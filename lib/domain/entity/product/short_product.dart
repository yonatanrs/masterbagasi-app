import 'product_appearance_data.dart';

class ShortProduct implements ProductAppearanceData {
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

  @override
  double get weight => 0.0;

  @override
  String get productId => id;

  ShortProduct({
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
  });
}