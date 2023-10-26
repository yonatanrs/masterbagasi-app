class ProductCategory {
  String id;
  String name;
  String slug;
  String? icon;
  String? bannerDesktop;
  String? bannerMobile;

  ProductCategory({
    required this.id,
    required this.name,
    required this.slug,
    required this.icon,
    required this.bannerDesktop,
    required this.bannerMobile
  });
}