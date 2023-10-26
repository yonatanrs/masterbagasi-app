import '../../../../domain/entity/address/country.dart';
import '../../../../presentation/widget/country/country_item.dart';
import '../list_item_controller_state.dart';

typedef OnGetSelectCountry = Country? Function();

class CountryContainerListItemControllerState extends ListItemControllerState {
  List<Country> country;
  OnSelectCountry? onSelectCountry;
  OnGetSelectCountry? onGetSelectCountry;
  void Function() onUpdateState;

  CountryContainerListItemControllerState({
    required this.country,
    this.onSelectCountry,
    this.onGetSelectCountry,
    required this.onUpdateState
  });
}