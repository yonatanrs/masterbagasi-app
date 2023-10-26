import '../../../../domain/entity/video/shortvideo/short_video.dart';
import '../../../load_data_result.dart';
import '../list_item_controller_state.dart';

class ShortVideoCarouselListItemControllerState extends ListItemControllerState {
  LoadDataResult<List<ShortVideo>> shortVideoListLoadDataResult;

  ShortVideoCarouselListItemControllerState({
    required this.shortVideoListLoadDataResult
  });
}