import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../entity/delivery/check_your_contribution_delivery_review_detail_parameter.dart';
import '../entity/delivery/check_your_contribution_delivery_review_detail_response.dart';
import '../entity/delivery/country_delivery_review.dart';
import '../entity/delivery/country_delivery_review_based_country_parameter.dart';
import '../entity/delivery/country_delivery_review_header_content.dart';
import '../entity/delivery/country_delivery_review_header_content_parameter.dart';
import '../entity/delivery/country_delivery_review_paging_parameter.dart';
import '../entity/delivery/country_delivery_review_response.dart';
import '../entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media_paging_parameter.dart';
import '../entity/delivery/delivery_review.dart';
import '../entity/delivery/delivery_review_list_parameter.dart';
import '../entity/delivery/delivery_review_paging_parameter.dart';
import '../entity/delivery/give_review_delivery_review_detail_parameter.dart';
import '../entity/delivery/give_review_delivery_review_detail_response.dart';
import '../entity/news/news.dart';
import '../entity/news/news_paging_parameter.dart';
import '../entity/video/defaultvideo/default_video.dart';
import '../entity/video/defaultvideo/default_video_list_parameter.dart';
import '../entity/video/shortvideo/short_video.dart';
import '../entity/video/shortvideo/short_video_list_parameter.dart';
import '../entity/video/shortvideo/short_video_paging_parameter.dart';

abstract class FeedRepository {
  FutureProcessing<LoadDataResult<PagingDataResult<ShortVideo>>> shortVideoPaging(ShortVideoPagingParameter shortVideoPagingParameter);
  FutureProcessing<LoadDataResult<List<ShortVideo>>> shortVideoList(ShortVideoListParameter shortVideoListParameter);
  FutureProcessing<LoadDataResult<List<DefaultVideo>>> defaultVideoList(DefaultVideoListParameter defaultVideoListParameter);
  FutureProcessing<LoadDataResult<List<DeliveryReview>>> deliveryReviewList(DeliveryReviewListParameter deliveryReviewListParameter);
  FutureProcessing<LoadDataResult<PagingDataResult<DeliveryReview>>> deliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter);
  FutureProcessing<LoadDataResult<PagingDataResult<DeliveryReview>>> waitingToBeReviewedDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter);
  FutureProcessing<LoadDataResult<PagingDataResult<DeliveryReview>>> historyDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter);
  FutureProcessing<LoadDataResult<PagingDataResult<News>>> newsPaging(NewsPagingParameter newsPagingParameter);
  FutureProcessing<LoadDataResult<CheckYourContributionDeliveryReviewDetailResponse>> checkYourContributionDeliveryReviewDetail(CheckYourContributionDeliveryReviewDetailParameter checkYourContributionDeliveryReviewDetailParameter);
  FutureProcessing<LoadDataResult<GiveReviewDeliveryReviewDetailResponse>> giveReviewDeliveryReviewDetail(GiveReviewDeliveryReviewDetailParameter giveReviewDeliveryReviewDetailParameter);
  FutureProcessing<LoadDataResult<CountryDeliveryReviewResponse>> countryDeliveryReview(CountryDeliveryReviewBasedCountryParameter countryDeliveryReviewBasedCountryParameter);
}