import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/delivery/give_review_delivery_review_detail_parameter.dart';
import '../entity/delivery/give_review_delivery_review_detail_response.dart';
import '../repository/feed_repository.dart';

class GiveReviewDeliveryReviewDetailUseCase {
  final FeedRepository feedRepository;

  const GiveReviewDeliveryReviewDetailUseCase({
    required this.feedRepository
  });

  FutureProcessing<LoadDataResult<GiveReviewDeliveryReviewDetailResponse>> execute(GiveReviewDeliveryReviewDetailParameter giveReviewDeliveryReviewDetailParameter) {
    return feedRepository.giveReviewDeliveryReviewDetail(giveReviewDeliveryReviewDetailParameter);
  }
}