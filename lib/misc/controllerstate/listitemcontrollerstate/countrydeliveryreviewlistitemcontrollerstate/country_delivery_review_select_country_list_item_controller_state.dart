import '../../../../domain/entity/address/country.dart';
import '../list_item_controller_state.dart';

class CountryDeliveryReviewSelectCountryListItemControllerState extends ListItemControllerState {
  final Country? selectedCountry;
  final void Function(Country)? onSelectCountry;

  CountryDeliveryReviewSelectCountryListItemControllerState({
    required this.selectedCountry,
    required this.onSelectCountry
  });
}