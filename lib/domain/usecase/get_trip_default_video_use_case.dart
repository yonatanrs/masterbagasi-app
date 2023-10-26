import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/video/defaultvideo/default_video.dart';
import '../entity/video/defaultvideo/default_video_list_parameter.dart';
import '../repository/feed_repository.dart';

class GetTripDefaultVideoUseCase {
  final FeedRepository feedRepository;

  const GetTripDefaultVideoUseCase({
    required this.feedRepository
  });

  FutureProcessing<LoadDataResult<List<DefaultVideo>>> execute() {
    return feedRepository.defaultVideoList(DefaultVideoListParameter());
  }
}