import '../../../../domain/entity/video/defaultvideo/default_video.dart';
import '../../../load_data_result.dart';
import '../list_item_controller_state.dart';

class DefaultVideoCarouselListItemControllerState extends ListItemControllerState {
  LoadDataResult<List<DefaultVideo>> defaultVideoListLoadDataResult;

  DefaultVideoCarouselListItemControllerState({
    required this.defaultVideoListLoadDataResult
  });
}