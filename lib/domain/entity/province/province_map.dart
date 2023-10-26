import 'province_map_metadata.dart';

class ProvinceMap {
  String id;
  String name;
  String? description;
  String slug;
  String? icon;
  String? background;
  String? bannerDesktop;
  String? bannerMobile;
  ProvinceMapMetadata provinceMapMetadata;

  ProvinceMap({
    required this.id,
    required this.name,
    required this.description,
    required this.slug,
    required this.icon,
    required this.background,
    required this.bannerDesktop,
    required this.bannerMobile,
    required this.provinceMapMetadata
  });
}