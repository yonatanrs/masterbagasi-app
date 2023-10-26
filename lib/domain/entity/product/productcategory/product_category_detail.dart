import '../short_product.dart';
import 'product_category.dart';

class ProductCategoryDetail extends ProductCategory {
  final List<ShortProduct> shortProductList;

  ProductCategoryDetail({
    required String id,
    required String name,
    required String slug,
    String? icon,
    String? bannerDesktop,
    String? bannerMobile,
    required this.shortProductList
  }) : super(
    id: id,
    name: name,
    slug: slug,
    icon: icon,
    bannerDesktop: bannerDesktop,
    bannerMobile: bannerMobile,
  );
}