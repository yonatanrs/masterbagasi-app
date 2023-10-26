import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../domain/entity/address/address.dart';
import '../domain/entity/address/address_list_parameter.dart';
import '../domain/entity/address/address_paging_parameter.dart';
import '../domain/entity/address/remove_address_parameter.dart';
import '../domain/entity/address/remove_address_response.dart';
import '../domain/entity/address/update_current_selected_address_parameter.dart';
import '../domain/entity/address/update_current_selected_address_response.dart';
import '../domain/usecase/get_address_list_use_case.dart';
import '../domain/usecase/get_address_paging_use_case.dart';
import '../domain/usecase/remove_address_use_case.dart';
import '../domain/usecase/update_current_selected_address_use_case.dart';
import '../misc/load_data_result.dart';
import '../misc/paging/pagingresult/paging_data_result.dart';
import '../misc/typedef.dart';
import 'base_getx_controller.dart';

typedef _OnGetAddressInput = Address Function();
typedef _OnAddressBack = void Function();
typedef _OnShowAddressRequestProcessLoadingCallback = Future<void> Function();
typedef _OnAddressRequestProcessSuccessCallback = Future<void> Function();
typedef _OnRemoveAddressRequestProcessSuccessCallback = Future<void> Function(Address);
typedef _OnShowAddressRequestProcessFailedCallback = Future<void> Function(dynamic e);

class AddressController extends BaseGetxController {
  final GetAddressPagingUseCase getAddressPagingUseCase;
  final GetAddressListUseCase getAddressListUseCase;
  final UpdateCurrentSelectedAddressUseCase updateCurrentSelectedAddressUseCase;
  final RemoveAddressUseCase removeAddressUseCase;
  AddressDelegate? _addressDelegate;

  AddressController(
    super.controllerManager,
    this.getAddressPagingUseCase,
    this.getAddressListUseCase,
    this.updateCurrentSelectedAddressUseCase,
    this.removeAddressUseCase
  );

  Future<LoadDataResult<List<Address>>> getAddressList(AddressListParameter addressListParameter) {
    return getAddressListUseCase.execute(addressListParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("address-list").value
    );
  }

  Future<LoadDataResult<PagingDataResult<Address>>> getAddressPaging(AddressPagingParameter addressPagingParameter) {
    return getAddressPagingUseCase.execute(addressPagingParameter).future(
      parameter: apiRequestManager.addRequestToCancellationPart("address-paging").value
    );
  }

  AddressController setAddressDelegate(AddressDelegate addressDelegate) {
    _addressDelegate = addressDelegate;
    return this;
  }

  void updateCurrentSelectedAddress() async {
    if (_addressDelegate != null) {
      _addressDelegate!.onUnfocusAllWidget();
      _addressDelegate!.onShowAddressRequestProcessLoadingCallback();
      LoadDataResult<UpdateCurrentSelectedAddressResponse> updateCurrentSelectedAddressResponseLoadDataResult = await updateCurrentSelectedAddressUseCase.execute(
        UpdateCurrentSelectedAddressParameter(
          addressId: _addressDelegate!.onGetAddressInput().id
        )
      ).future(
        parameter: apiRequestManager.addRequestToCancellationPart('login').value
      );
      _addressDelegate!.onAddressBack();
      if (updateCurrentSelectedAddressResponseLoadDataResult.isSuccess) {
        _addressDelegate!.onAddressRequestProcessSuccessCallback();
      } else {
        _addressDelegate!.onShowAddressRequestProcessFailedCallback(updateCurrentSelectedAddressResponseLoadDataResult.resultIfFailed);
      }
    }
  }

  void removeAddress(Address address) async {
    if (_addressDelegate != null) {
      _addressDelegate!.onUnfocusAllWidget();
      _addressDelegate!.onShowAddressRequestProcessLoadingCallback();
      LoadDataResult<RemoveAddressResponse> removeAddressResponseLoadDataResult = await removeAddressUseCase.execute(
        RemoveAddressParameter(
          addressId: address.id
        )
      ).future(
        parameter: apiRequestManager.addRequestToCancellationPart('remove-address').value
      );
      _addressDelegate!.onAddressBack();
      if (removeAddressResponseLoadDataResult.isSuccess) {
        _addressDelegate!.onRemoveAddressRequestProcessSuccessCallback(address);
      } else {
        _addressDelegate!.onShowAddressRequestProcessFailedCallback(removeAddressResponseLoadDataResult.resultIfFailed);
      }
    }
  }
}

class AddressDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnAddressBack onAddressBack;
  _OnGetAddressInput onGetAddressInput;
  _OnShowAddressRequestProcessLoadingCallback onShowAddressRequestProcessLoadingCallback;
  _OnAddressRequestProcessSuccessCallback onAddressRequestProcessSuccessCallback;
  _OnRemoveAddressRequestProcessSuccessCallback onRemoveAddressRequestProcessSuccessCallback;
  _OnShowAddressRequestProcessFailedCallback onShowAddressRequestProcessFailedCallback;

  AddressDelegate({
    required this.onUnfocusAllWidget,
    required this.onAddressBack,
    required this.onGetAddressInput,
    required this.onShowAddressRequestProcessLoadingCallback,
    required this.onAddressRequestProcessSuccessCallback,
    required this.onRemoveAddressRequestProcessSuccessCallback,
    required this.onShowAddressRequestProcessFailedCallback
  });
}