import '../../domain/entity/delivery/check_your_contribution_delivery_review_detail_parameter.dart';
import '../../domain/entity/delivery/check_your_contribution_delivery_review_detail_response.dart';
import '../../domain/entity/delivery/country_delivery_review.dart';
import '../../domain/entity/delivery/country_delivery_review_based_country_parameter.dart';
import '../../domain/entity/delivery/country_delivery_review_header_content.dart';
import '../../domain/entity/delivery/country_delivery_review_header_content_parameter.dart';
import '../../domain/entity/delivery/country_delivery_review_paging_parameter.dart';
import '../../domain/entity/delivery/country_delivery_review_response.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media_paging_parameter.dart';
import '../../domain/entity/delivery/delivery_review.dart';
import '../../domain/entity/delivery/delivery_review_list_parameter.dart';
import '../../domain/entity/delivery/delivery_review_paging_parameter.dart';
import '../../domain/entity/delivery/give_review_delivery_review_detail_parameter.dart';
import '../../domain/entity/delivery/give_review_delivery_review_detail_response.dart';
import '../../domain/entity/news/news.dart';
import '../../domain/entity/news/news_paging_parameter.dart';
import '../../domain/entity/video/defaultvideo/default_video.dart';
import '../../domain/entity/video/defaultvideo/default_video_list_parameter.dart';
import '../../domain/entity/video/shortvideo/short_video.dart';
import '../../domain/entity/video/shortvideo/short_video_list_parameter.dart';
import '../../domain/entity/video/shortvideo/short_video_paging_parameter.dart';
import '../../domain/repository/feed_repository.dart';
import '../../misc/load_data_result.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/processing/future_processing.dart';
import '../datasource/feeddatasource/feed_data_source.dart';

class DefaultFeedRepository implements FeedRepository {
  final FeedDataSource feedDataSource;

  const DefaultFeedRepository({
    required this.feedDataSource
  });

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<ShortVideo>>> shortVideoPaging(ShortVideoPagingParameter shortVideoPagingParameter) {
    return feedDataSource.shortVideoPaging(shortVideoPagingParameter).mapToLoadDataResult<PagingDataResult<ShortVideo>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<ShortVideo>>> shortVideoList(ShortVideoListParameter shortVideoListParameter) {
    return feedDataSource.shortVideoList(shortVideoListParameter).mapToLoadDataResult<List<ShortVideo>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<DefaultVideo>>> defaultVideoList(DefaultVideoListParameter defaultVideoListParameter) {
    return feedDataSource.defaultVideoList(defaultVideoListParameter).mapToLoadDataResult<List<DefaultVideo>>();
  }

  @override
  FutureProcessing<LoadDataResult<List<DeliveryReview>>> deliveryReviewList(DeliveryReviewListParameter deliveryReviewListParameter) {
    return feedDataSource.deliveryReviewList(deliveryReviewListParameter).mapToLoadDataResult<List<DeliveryReview>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<DeliveryReview>>> deliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return feedDataSource.deliveryReviewPaging(deliveryReviewPagingParameter).mapToLoadDataResult<PagingDataResult<DeliveryReview>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<DeliveryReview>>> waitingToBeReviewedDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return feedDataSource.waitingToBeReviewedDeliveryReviewPaging(deliveryReviewPagingParameter).mapToLoadDataResult<PagingDataResult<DeliveryReview>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<DeliveryReview>>> historyDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return feedDataSource.historyDeliveryReviewPaging(deliveryReviewPagingParameter).mapToLoadDataResult<PagingDataResult<DeliveryReview>>();
  }

  @override
  FutureProcessing<LoadDataResult<PagingDataResult<News>>> newsPaging(NewsPagingParameter newsPagingParameter) {
    return feedDataSource.newsPaging(newsPagingParameter).mapToLoadDataResult<PagingDataResult<News>>();
  }

  @override
  FutureProcessing<LoadDataResult<CheckYourContributionDeliveryReviewDetailResponse>> checkYourContributionDeliveryReviewDetail(CheckYourContributionDeliveryReviewDetailParameter checkYourContributionDeliveryReviewDetailParameter) {
    return feedDataSource.checkYourContributionDeliveryReviewDetail(checkYourContributionDeliveryReviewDetailParameter).mapToLoadDataResult<CheckYourContributionDeliveryReviewDetailResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<GiveReviewDeliveryReviewDetailResponse>> giveReviewDeliveryReviewDetail(GiveReviewDeliveryReviewDetailParameter giveReviewDeliveryReviewDetailParameter) {
    return feedDataSource.giveReviewDeliveryReviewDetail(giveReviewDeliveryReviewDetailParameter).mapToLoadDataResult<GiveReviewDeliveryReviewDetailResponse>();
  }

  @override
  FutureProcessing<LoadDataResult<CountryDeliveryReviewResponse>> countryDeliveryReview(CountryDeliveryReviewBasedCountryParameter countryDeliveryReviewBasedCountryParameter) {
    return feedDataSource.countryDeliveryReview(countryDeliveryReviewBasedCountryParameter).mapToLoadDataResult<CountryDeliveryReviewResponse>();
  }
}