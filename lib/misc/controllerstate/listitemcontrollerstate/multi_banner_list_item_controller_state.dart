import '../../../domain/entity/banner/banner.dart';
import '../../aspect_ratio_value.dart';
import 'list_item_controller_state.dart';

class MultiBannerListItemControllerState extends ListItemControllerState {
  List<Banner> bannerList;
  AspectRatioValue aspectRatioValue;

  MultiBannerListItemControllerState({
    required this.bannerList,
    required this.aspectRatioValue
  });
}