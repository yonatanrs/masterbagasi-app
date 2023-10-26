import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/delivery/delivery_review.dart';
import '../entity/delivery/delivery_review_paging_parameter.dart';
import '../repository/feed_repository.dart';

class GetWaitingToBeReviewedDeliveryReviewPagingUseCase {
  final FeedRepository feedRepository;

  const GetWaitingToBeReviewedDeliveryReviewPagingUseCase({
    required this.feedRepository
  });

  FutureProcessing<LoadDataResult<PagingDataResult<DeliveryReview>>> execute(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return feedRepository.waitingToBeReviewedDeliveryReviewPaging(deliveryReviewPagingParameter);
  }
}