import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/delivery/delivery_review.dart';
import '../entity/delivery/delivery_review_list_parameter.dart';
import '../repository/feed_repository.dart';

class GetDeliveryReviewUseCase {
  final FeedRepository feedRepository;

  const GetDeliveryReviewUseCase({
    required this.feedRepository
  });

  FutureProcessing<LoadDataResult<List<DeliveryReview>>> execute() {
    return feedRepository.deliveryReviewList(DeliveryReviewListParameter());
  }
}