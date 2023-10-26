import '../../../../domain/entity/address/country.dart';
import '../../../../presentation/widget/country/country_item.dart';
import '../list_item_controller_state.dart';

abstract class CountryListItemControllerState extends ListItemControllerState {
  Country country;
  bool isSelected;
  OnSelectCountry? onSelectCountry;

  CountryListItemControllerState({
    required this.country,
    required this.isSelected,
    this.onSelectCountry
  });
}