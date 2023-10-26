import 'package:dio/dio.dart';
import 'package:masterbagasi/data/entitymappingext/delivery_review_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/news_entity_mapping_ext.dart';
import 'package:masterbagasi/data/entitymappingext/video_entity_mapping_ext.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/response_wrapper_ext.dart';

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
import '../../../domain/entity/delivery/countrydeliveryreviewmedia/photo_country_delivery_review_media.dart';
import '../../../domain/entity/delivery/countrydeliveryreviewmedia/video_country_delivery_review_media.dart';
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
import '../../../misc/processing/dio_http_client_processing.dart';
import '../../../misc/processing/dummy_future_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'feed_data_source.dart';

class DefaultFeedDataSource implements FeedDataSource {
  final Dio dio;

  const DefaultFeedDataSource({
    required this.dio
  });

  @override
  FutureProcessing<PagingDataResult<ShortVideo>> shortVideoPaging(ShortVideoPagingParameter shortVideoPagingParameter) {
    throw UnimplementedError();
  }

  @override
  FutureProcessing<List<ShortVideo>> shortVideoList(ShortVideoListParameter shortVideoListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/youtube/type/shorts", cancelToken: cancelToken)
        .map<List<ShortVideo>>(onMap: (value) => value.wrapResponse().mapFromResponseToShortVideoList());
    });
  }

  @override
  FutureProcessing<List<DefaultVideo>> defaultVideoList(DefaultVideoListParameter defaultVideoListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/youtube/type/video", cancelToken: cancelToken)
        .map<List<DefaultVideo>>(onMap: (value) => value.wrapResponse().mapFromResponseToDefaultVideoList());
    });
  }

  @override
  FutureProcessing<List<DeliveryReview>> deliveryReviewList(DeliveryReviewListParameter deliveryReviewListParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/shipping-review", cancelToken: cancelToken)
        .map<List<DeliveryReview>>(onMap: (value) => value.wrapResponse().mapFromResponseToDeliveryReviewList());
    });
  }

  @override
  FutureProcessing<PagingDataResult<DeliveryReview>> deliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return DummyFutureProcessing((cancelToken) async {
      await Future.delayed(const Duration(seconds: 1));
      return PagingDataResult<DeliveryReview>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          DeliveryReview(
            id: "1",
            userName: "Ciya",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Korea Selatan",
            review: "Review 1",
            reviewDate: DateTime.now(),
          ),
          DeliveryReview(
            id: "2",
            userName: "Dandi",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Turki",
            review: "Review 2",
            reviewDate: DateTime.now(),
          ),
          DeliveryReview(
            id: "3",
            userName: "Naufal",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Jepang",
            review: "Review 3",
            reviewDate: DateTime.now(),
          )
        ]
      );
    });
  }

  @override
  FutureProcessing<PagingDataResult<DeliveryReview>> waitingToBeReviewedDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return DummyFutureProcessing((cancelToken) async {
      await Future.delayed(const Duration(seconds: 1));
      return PagingDataResult<DeliveryReview>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          DeliveryReview(
            id: "1",
            userName: "Ciya",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Korea Selatan",
            review: "Review 1",
            reviewDate: DateTime.now(),
          ),
          DeliveryReview(
            id: "2",
            userName: "Dandi",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Turki",
            review: "Review 2",
            reviewDate: DateTime.now(),
          ),
          DeliveryReview(
            id: "3",
            userName: "Naufal",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Jepang",
            review: "Review 3",
            reviewDate: DateTime.now(),
          )
        ]
      );
    });
  }

  @override
  FutureProcessing<PagingDataResult<DeliveryReview>> historyDeliveryReviewPaging(DeliveryReviewPagingParameter deliveryReviewPagingParameter) {
    return DummyFutureProcessing((cancelToken) async {
      await Future.delayed(const Duration(seconds: 1));
      return PagingDataResult<DeliveryReview>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          DeliveryReview(
            id: "1",
            userName: "Ciya",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Korea Selatan",
            review: "Review 1",
            reviewDate: DateTime.now(),
          ),
          DeliveryReview(
            id: "2",
            userName: "Dandi",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Turki",
            review: "Review 2",
            reviewDate: DateTime.now(),
          ),
          DeliveryReview(
            id: "3",
            userName: "Naufal",
            userProfilePicture: "",
            productImageUrl: "",
            productName: "",
            rating: 5.0,
            country: "Jepang",
            review: "Review 3",
            reviewDate: DateTime.now(),
          )
        ]
      );
    });
  }

  @override
  FutureProcessing<PagingDataResult<News>> newsPaging(NewsPagingParameter newsPagingParameter) {
    return DioHttpClientProcessing((cancelToken) {
      String pageParameterPath = "/?pageNumber=${newsPagingParameter.itemEachPageCount}&page=${newsPagingParameter.page}";
      return dio.get("/news$pageParameterPath", cancelToken: cancelToken)
        .map<PagingDataResult<News>>(onMap: (value) => value.wrapResponse().mapFromResponseToNewsPaging());
    });
  }

  @override
  FutureProcessing<CheckYourContributionDeliveryReviewDetailResponse> checkYourContributionDeliveryReviewDetail(CheckYourContributionDeliveryReviewDetailParameter checkYourContributionDeliveryReviewDetailParameter) {
    return DummyFutureProcessing((cancelToken) async {
      await Future.delayed(const Duration(seconds: 1));
      return CheckYourContributionDeliveryReviewDetailResponse(
        ratingCount: 10,
        fullReviewCount: 10,
        photoAndVideoCount: 10
      );
    });
  }

  @override
  FutureProcessing<GiveReviewDeliveryReviewDetailResponse> giveReviewDeliveryReviewDetail(GiveReviewDeliveryReviewDetailParameter giveReviewDeliveryReviewDetailParameter) {
    return DummyFutureProcessing((cancelToken) async {
      await Future.delayed(const Duration(seconds: 1));
      return GiveReviewDeliveryReviewDetailResponse();
    });
  }

  @override
  FutureProcessing<CountryDeliveryReviewResponse> countryDeliveryReview(CountryDeliveryReviewBasedCountryParameter countryDeliveryReviewBasedCountryParameter) {
    return DioHttpClientProcessing((cancelToken) {
      return dio.get("/shipping-review/country/${countryDeliveryReviewBasedCountryParameter.countryId}", cancelToken: cancelToken)
        .map<CountryDeliveryReviewResponse>(onMap: (value) => value.wrapResponse().mapFromResponseToCountryDeliveryReviewResponse());
    });
  }
}