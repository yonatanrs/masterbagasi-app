import '../../../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../../paging/pagingresult/paging_data_result.dart';
import '../list_item_controller_state.dart';

abstract class BaseCountryDeliveryReviewMediaShortContentListItemControllerState extends ListItemControllerState {}

class ShimmerCountryDeliveryReviewMediaShortContentListItemControllerState extends BaseCountryDeliveryReviewMediaShortContentListItemControllerState {}

class CountryDeliveryReviewMediaShortContentListItemControllerState extends BaseCountryDeliveryReviewMediaShortContentListItemControllerState {
  List<CountryDeliveryReviewMedia> countryDeliveryReviewMediaList;

  CountryDeliveryReviewMediaShortContentListItemControllerState({
    required this.countryDeliveryReviewMediaList
  });
}