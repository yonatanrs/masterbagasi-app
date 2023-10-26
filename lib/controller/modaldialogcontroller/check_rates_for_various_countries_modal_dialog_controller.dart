import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/rx_ext.dart';

import '../../domain/entity/address/country.dart';
import '../../domain/entity/cargo/cargo.dart';
import '../../domain/entity/cargo/cargo_list_parameter.dart';
import '../../domain/usecase/check_rates_for_various_countries_use_case.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import 'modal_dialog_controller.dart';

typedef _OnGetSelectedCountry = Country? Function();

class CheckRatesForVariousCountriesModalDialogController extends ModalDialogController {
  final CheckRatesForVariousCountriesUseCase checkRatesForVariousCountriesUseCase;

  LoadDataResult<List<Cargo>> _cargoLoadDataResult = NoLoadDataResult<List<Cargo>>();
  late Rx<LoadDataResultWrapper<List<Cargo>>> cargoLoadDataResultWrapperRx;

  CartDelegate? _cartDelegate;

  CheckRatesForVariousCountriesModalDialogController(
    ControllerManager? controllerManager,
    this.checkRatesForVariousCountriesUseCase
  ) : super(controllerManager) {
    cargoLoadDataResultWrapperRx = LoadDataResultWrapper<List<Cargo>>(_cargoLoadDataResult).obs;
  }

  void loadCargo() async {
    if (_cartDelegate != null) {
      Country? selectedCountry = _cartDelegate!.onGetSelectedCountry();
      if (selectedCountry != null) {
        _cargoLoadDataResult = IsLoadingLoadDataResult<List<Cargo>>();
        _updateCheckRatesForVariousCountriesState();
        _cargoLoadDataResult = await checkRatesForVariousCountriesUseCase.execute(
          CargoListParameter(zoneId: selectedCountry.zoneId)
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart("cargo").value
        );
        _updateCheckRatesForVariousCountriesState();
      }
    }
  }

  void _updateCheckRatesForVariousCountriesState() {
    cargoLoadDataResultWrapperRx.valueFromLast(
      (value) => LoadDataResultWrapper<List<Cargo>>(_cargoLoadDataResult)
    );
    update();
  }

  CheckRatesForVariousCountriesModalDialogController setCartDelegate(CartDelegate cartDelegate) {
    _cartDelegate = cartDelegate;
    return this;
  }
}

class CartDelegate {
  _OnGetSelectedCountry onGetSelectedCountry;

  CartDelegate({
    required this.onGetSelectedCountry
  });
}