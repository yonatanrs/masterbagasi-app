class Province {
  String id;
  String name;
  String? description;
  String slug;
  String? icon;
  String? background;
  String? bannerDesktop;
  String? bannerMobile;

  Province({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.icon,
    required this.background,
    required this.bannerDesktop,
    required this.bannerMobile
  });
}