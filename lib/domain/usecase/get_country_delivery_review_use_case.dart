import '../../misc/load_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/delivery/country_delivery_review_based_country_parameter.dart';
import '../entity/delivery/country_delivery_review_response.dart';
import '../repository/feed_repository.dart';

class GetCountryDeliveryReviewUseCase {
  final FeedRepository feedRepository;

  const GetCountryDeliveryReviewUseCase({
    required this.feedRepository
  });

  FutureProcessing<LoadDataResult<CountryDeliveryReviewResponse>> execute(CountryDeliveryReviewBasedCountryParameter countryDeliveryReviewBasedCountryParameter) {
    return feedRepository.countryDeliveryReview(countryDeliveryReviewBasedCountryParameter);
  }
}