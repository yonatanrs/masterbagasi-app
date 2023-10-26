import '../short_product.dart';
import 'product_brand.dart';

class ProductBrandDetail extends ProductBrand {
  final List<ShortProduct> shortProductList;

  ProductBrandDetail({
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