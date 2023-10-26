import '../../../domain/entity/delivery/check_your_contribution_delivery_review_detail_parameter.dart';
import '../../../domain/entity/delivery/check_your_contribution_delivery_review_detail_response.dart';
import '../../../domain/entity/delivery/country_delivery_review.dart';
import '../../../domain/entity/delivery/country_delivery_review_based_country_parameter.dart';
import '../../../domain/entity/delivery/country_delivery_review_header_content.dart';
import '../../../domain/entity/delivery/country_delivery_review_header_content_parameter.dart';
import '../../../domain/entity/delivery/country_delivery_review_paging_parameter.dart';
import '../../../domain/entity/delivery/country_delivery_review_response.dart';
import '../../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media_paging_parameter.dart';
import '../../../domain/entity/delivery/delivery_review.dart';
import '../../../domain/entity/delivery/delivery_review_list_parameter.dart';
import '../../../domain/entity/delivery/delivery_review_paging_parameter.dart';
import '../../../domain/entity/delivery/give_review_delivery_review_detail_parameter.dart';
import '../../../domain/entity/delivery/give_review_delivery_review_detail_response.dart';
import '../../../domain/entity/news/news.dart';
import '../../../domain/entity/news/news_paging_parameter.dart';
import '../../../domain/entity/video/defaultvideo/default_video.dart';
import '../../../domain/entity/video/defaultvideo/default_video_list_parameter.dart';
import '../../../domain/entity/video/shortvideo/short_video.dart';
import '../../../domain/entity/video/shortvideo/short_video_list_parameter.dart';
import '../../../domain/entity/video/shortvideo/short_video_paging_parameter.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/processing/future_processing.dart';

abstract class FeedDataSource {
  FutureProcessing<PagingDataResult<ShortVideo>> shortVideoPaging(ShortVideoPagingParameter shortVideoPagingParameter);
  FutureProcessing<List<ShortVideo>> shortVideoList(ShortVideoListParameter shortVideoPagingParameter);
  FutureProcessing<List<DefaultVideo>> defaultVideoList(DefaultVideoListParameter defaultVideoListParameter);
  FutureProcessing<List<DeliveryReview>> deliveryReviewList(DeliveryReviewListParameter deliveryReviewListParameter);
  FutureProcessing<PagingDataResult<DeliveryReview>> deliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter);
  FutureProcessing<PagingDataResult<DeliveryReview>> waitingToBeReviewedDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter);
  FutureProcessing<PagingDataResult<DeliveryReview>> historyDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter);
  FutureProcessing<PagingDataResult<News>> newsPaging(NewsPagingParameter newsPagingParameter);
  FutureProcessing<CheckYourContributionDeliveryReviewDetailResponse> checkYourContributionDeliveryReviewDetail(CheckYourContributionDeliveryReviewDetailParameter checkYourContributionDeliveryReviewDetailParameter);
  FutureProcessing<GiveReviewDeliveryReviewDetailResponse> giveReviewDeliveryReviewDetail(GiveReviewDeliveryReviewDetailParameter giveReviewDeliveryReviewDetailParameter);
  FutureProcessing<CountryDeliveryReviewResponse> countryDeliveryReview(CountryDeliveryReviewBasedCountryParameter countryDeliveryReviewBasedCountryParameter);
}