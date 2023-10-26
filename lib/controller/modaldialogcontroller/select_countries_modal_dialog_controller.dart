import '../../domain/entity/address/country.dart';
import '../../domain/entity/address/country_paging_parameter.dart';
import '../../domain/usecase/get_country_paging_use_case.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import 'modal_dialog_controller.dart';

class SelectCountriesModalDialogController extends ModalDialogController {
  final GetCountryPagingUseCase getCountryPagingUseCase;

  SelectCountriesModalDialogController(
    ControllerManager? controllerManager,
    this.getCountryPagingUseCase
  ) : super(controllerManager);

  Future<LoadDataResult<PagingDataResult<Country>>> getCountryPaging(CountryPagingParameter countryPagingParameter) {
    return getCountryPagingUseCase.execute(countryPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("country").value
    );
  }
}