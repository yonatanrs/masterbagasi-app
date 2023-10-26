import '../../../../domain/entity/address/country.dart';
import '../../../../domain/entity/delivery/country_delivery_review_header_content.dart';
import '../../../load_data_result.dart';
import '../list_item_controller_state.dart';

abstract class BaseCountryDeliveryReviewHeaderListItemControllerState extends ListItemControllerState {}

class ShimmerCountryDeliveryReviewHeaderListItemControllerState extends BaseCountryDeliveryReviewHeaderListItemControllerState {}

class CountryDeliveryReviewHeaderListItemControllerState extends BaseCountryDeliveryReviewHeaderListItemControllerState {
  CountryDeliveryReviewHeaderContent countryDeliveryReviewHeaderContent;

  CountryDeliveryReviewHeaderListItemControllerState({
    required this.countryDeliveryReviewHeaderContent
  });
}