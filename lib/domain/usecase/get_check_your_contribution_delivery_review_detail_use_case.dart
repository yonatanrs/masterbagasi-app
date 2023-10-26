import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/delivery/check_your_contribution_delivery_review_detail_parameter.dart';
import '../entity/delivery/check_your_contribution_delivery_review_detail_response.dart';
import '../repository/feed_repository.dart';

class GetCheckYourContributionDeliveryReviewDetailUseCase {
  final FeedRepository feedRepository;

  const GetCheckYourContributionDeliveryReviewDetailUseCase({
    required this.feedRepository
  });

  FutureProcessing<LoadDataResult<CheckYourContributionDeliveryReviewDetailResponse>> execute(CheckYourContributionDeliveryReviewDetailParameter checkYourContributionDeliveryReviewDetailParameter) {
    return feedRepository.checkYourContributionDeliveryReviewDetail(checkYourContributionDeliveryReviewDetailParameter);
  }
}