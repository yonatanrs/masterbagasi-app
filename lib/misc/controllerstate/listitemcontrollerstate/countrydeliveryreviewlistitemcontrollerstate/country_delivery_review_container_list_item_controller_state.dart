import '../../../../domain/entity/delivery/country_delivery_review.dart';
import '../../../../domain/entity/delivery/country_delivery_review_response.dart';
import '../../../errorprovider/error_provider.dart';
import '../../../load_data_result.dart';
import '../list_item_controller_state.dart';

class CountryDeliveryReviewContainerListItemControllerState extends ListItemControllerState {
  List<CountryDeliveryReview> countryDeliveryReviewList;
  void Function() onUpdateState;
  ErrorProvider errorProvider;
  ListItemControllerState Function() getCountryDeliveryReviewSelectCountryListItemControllerState;
  ListItemControllerState Function() getCountryDeliveryReviewHeaderListItemControllerState;
  ListItemControllerState Function() getCountryDeliveryReviewMediaShortContentListItemControllerState;

  CountryDeliveryReviewContainerListItemControllerState({
    required this.countryDeliveryReviewList,
    required this.onUpdateState,
    required this.errorProvider,
    required this.getCountryDeliveryReviewSelectCountryListItemControllerState,
    required this.getCountryDeliveryReviewHeaderListItemControllerState,
    required this.getCountryDeliveryReviewMediaShortContentListItemControllerState
  });
}