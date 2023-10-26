import '../../../domain/entity/banner/banner.dart';
import '../../aspect_ratio_value.dart';
import 'list_item_controller_state.dart';

class SingleBannerListItemControllerState extends ListItemControllerState {
  Banner banner;
  AspectRatioValue aspectRatioValue;

  SingleBannerListItemControllerState({
    required this.banner,
    required this.aspectRatioValue
  });
}