import '../../../misc/aspect_ratio_value.dart';
import '../banner/banner.dart';
import 'home_main_menu_component_entity.dart';

class BannerHomeMainMenuComponentEntity extends HomeMainMenuComponentEntity {
  Banner banner;
  AspectRatioValue aspectRatioValue;

  BannerHomeMainMenuComponentEntity({
    required this.banner,
    required this.aspectRatioValue
  });
}