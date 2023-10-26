import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../domain/entity/address/add_address_parameter.dart';
import '../domain/entity/address/address.dart';
import '../domain/entity/address/address_based_id_parameter.dart';
import '../domain/entity/address/change_address_parameter.dart';
import '../domain/entity/address/country.dart';
import '../domain/usecase/add_address_use_case.dart';
import '../domain/usecase/change_address_use_case.dart';
import '../domain/usecase/get_address_based_id_use_case.dart';
import '../misc/error/validation_error.dart';
import '../misc/load_data_result.dart';
import '../misc/processing/future_processing.dart';
import '../misc/typedef.dart';
import '../misc/validation/validation_result.dart';
import '../misc/validation/validator/email_validator.dart';
import '../misc/validation/validator/validator.dart';
import '../misc/validation/validatorgroup/address_validator_group.dart';
import '../presentation/page/modify_address_page.dart';
import 'base_getx_controller.dart';

typedef _OnGetModifyAddressInput<T> = T Function();
typedef _OnGetModifyAddressPageParameterValue = ModifyAddressPageParameterValue? Function();
typedef _OnModifyAddressBack = void Function();
typedef _OnLoadSelectedAddressRequestProcessCallback = Future<void> Function(LoadDataResult<Address>);
typedef _OnShowModifyAddressRequestProcessLoadingCallback = Future<void> Function();
typedef _OnModifyAddressRequestProcessSuccessCallback = Future<void> Function();
typedef _OnShowModifyAddressRequestProcessFailedCallback = Future<void> Function(dynamic e);

class ModifyAddressController extends BaseGetxController {
  final AddAddressUseCase addAddressUseCase;
  final ChangeAddressUseCase changeAddressUseCase;
  final GetAddressBasedIdUseCase getAddressBasedIdUseCase;

  late Rx<Validator> nameValidatorRx;
  late Rx<Validator> emailValidatorRx;
  late Rx<Validator> labelValidatorRx;
  late Rx<Validator> addressValidatorRx;
  late Rx<Validator> phoneNumberValidatorRx;
  late Rx<Validator> zipCodeValidatorRx;
  late Rx<Validator> countryValidatorRx;
  late Rx<Validator> cityValidatorRx;
  late Rx<Validator> stateValidatorRx;
  late final AddressValidatorGroup modifyAddressValidatorGroup;

  ModifyAddressDelegate? _modifyAddressDelegate;
  bool _hasLoadAddress = false;

  ModifyAddressController(
    super.controllerManager,
    this.addAddressUseCase,
    this.changeAddressUseCase,
    this.getAddressBasedIdUseCase
  ) {
    modifyAddressValidatorGroup = AddressValidatorGroup(
      nameValidator: Validator(
        onValidate: () => !_modifyAddressDelegate!.onGetNameModifyAddressInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Name is required".tr}."))
      ),
      emailValidator: EmailValidator(
        email: () => _modifyAddressDelegate!.onGetEmailModifyAddressInput()
      ),
      labelValidator: Validator(
        onValidate: () => !_modifyAddressDelegate!.onGetLabelModifyAddressInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Label is required".tr}."))
      ),
      addressValidator: Validator(
        onValidate: () => !_modifyAddressDelegate!.onGetAddressModifyAddressInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Address is required".tr}."))
      ),
      phoneNumberValidator: Validator(
        onValidate: () => !_modifyAddressDelegate!.onGetPhoneNumberModifyAddressInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Phone number is required".tr}."))
      ),
      zipCodeValidator: Validator(
        onValidate: () => !_modifyAddressDelegate!.onGetZipCodeModifyAddressInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Zip code is required".tr}."))
      ),
      countryValidator: Validator(
        onValidate: () => _modifyAddressDelegate!.onGetCountryModifyAddressInput() != null ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Country is required".tr}."))
      ),
      cityValidator: Validator(
        onValidate: () => !_modifyAddressDelegate!.onGetCityModifyAddressInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"City is required".tr}."))
      ),
      stateValidator: Validator(
        onValidate: () => !_modifyAddressDelegate!.onGetStateModifyAddressInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"State is required".tr}."))
      ),
    );
    nameValidatorRx = modifyAddressValidatorGroup.nameValidator.obs;
    emailValidatorRx = modifyAddressValidatorGroup.emailValidator.obs;
    labelValidatorRx = modifyAddressValidatorGroup.labelValidator.obs;
    addressValidatorRx = modifyAddressValidatorGroup.addressValidator.obs;
    phoneNumberValidatorRx = modifyAddressValidatorGroup.phoneNumberValidator.obs;
    zipCodeValidatorRx = modifyAddressValidatorGroup.zipCodeValidator.obs;
    countryValidatorRx = modifyAddressValidatorGroup.countryValidator.obs;
    cityValidatorRx = modifyAddressValidatorGroup.cityValidator.obs;
    stateValidatorRx = modifyAddressValidatorGroup.stateValidator.obs;
  }

  ModifyAddressController setModifyAddressDelegate(ModifyAddressDelegate modifyAddressDelegate) {
    _modifyAddressDelegate = modifyAddressDelegate;
    return this;
  }

  void reloadAddress() {
    _hasLoadAddress = false;
    loadAddress();
  }

  void loadAddress() async {
    if (_hasLoadAddress) {
      return;
    }
    _hasLoadAddress = true;
    if (_modifyAddressDelegate != null) {
      ModifyAddressPageParameterValue? modifyAddressPageParameterValue = _modifyAddressDelegate!.onGetModifyAddressPageParameterValue();
      if (modifyAddressPageParameterValue != null) {
        _modifyAddressDelegate!.onLoadSelectedAddressRequestProcessCallback(IsLoadingLoadDataResult<Address>());
        LoadDataResult<Address> addressLoadDataResult = await getAddressBasedIdUseCase.execute(
          AddressBasedIdParameter(
            addressId: modifyAddressPageParameterValue.addressId
          )
        ).future(
          parameter: apiRequestManager.addRequestToCancellationPart('load-address').value
        );
        _modifyAddressDelegate!.onLoadSelectedAddressRequestProcessCallback(addressLoadDataResult);
      }
    }
  }

  void submit() async {
    if (_modifyAddressDelegate != null) {
      _modifyAddressDelegate!.onUnfocusAllWidget();
      if (modifyAddressValidatorGroup.validate()) {
        _modifyAddressDelegate!.onShowModifyAddressRequestProcessLoadingCallback();
        late FutureProcessing<LoadDataResult> modifyAddressLoadDataResultFutureProcessing;
        ModifyAddressPageParameterValue? modifyAddressPageParameterValue = _modifyAddressDelegate!.onGetModifyAddressPageParameterValue();
        if (modifyAddressPageParameterValue == null) {
          modifyAddressLoadDataResultFutureProcessing = addAddressUseCase.execute(
            AddAddressParameter(
              name: _modifyAddressDelegate!.onGetNameModifyAddressInput(),
              email: _modifyAddressDelegate!.onGetEmailModifyAddressInput(),
              label: _modifyAddressDelegate!.onGetLabelModifyAddressInput(),
              address: _modifyAddressDelegate!.onGetAddressModifyAddressInput(),
              phoneNumber: _modifyAddressDelegate!.onGetPhoneNumberModifyAddressInput(),
              zipCode: _modifyAddressDelegate!.onGetZipCodeModifyAddressInput(),
              countryId: _modifyAddressDelegate!.onGetCountryModifyAddressInput()!.id,
              city: _modifyAddressDelegate!.onGetCityModifyAddressInput(),
              state: _modifyAddressDelegate!.onGetStateModifyAddressInput()
            )
          );
        } else {
          modifyAddressLoadDataResultFutureProcessing = changeAddressUseCase.execute(
            ChangeAddressParameter(
              addressId: modifyAddressPageParameterValue.addressId,
              name: _modifyAddressDelegate!.onGetNameModifyAddressInput(),
              email: _modifyAddressDelegate!.onGetEmailModifyAddressInput(),
              label: _modifyAddressDelegate!.onGetLabelModifyAddressInput(),
              address: _modifyAddressDelegate!.onGetAddressModifyAddressInput(),
              phoneNumber: _modifyAddressDelegate!.onGetPhoneNumberModifyAddressInput(),
              zipCode: _modifyAddressDelegate!.onGetZipCodeModifyAddressInput(),
              countryId: _modifyAddressDelegate!.onGetCountryModifyAddressInput()!.id,
              city: _modifyAddressDelegate!.onGetCityModifyAddressInput(),
              state: _modifyAddressDelegate!.onGetStateModifyAddressInput()
            )
          );
        }
        LoadDataResult modifyAddressLoadDataResult = await modifyAddressLoadDataResultFutureProcessing.future(
          parameter: apiRequestManager.addRequestToCancellationPart('modify-address').value
        );
        _modifyAddressDelegate!.onModifyAddressBack();
        if (modifyAddressLoadDataResult.isSuccess) {
          _modifyAddressDelegate!.onModifyAddressRequestProcessSuccessCallback();
        } else {
          _modifyAddressDelegate!.onShowModifyAddressRequestProcessFailedCallback(modifyAddressLoadDataResult.resultIfFailed);
        }
      }
    }
  }
}

class ModifyAddressDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnGetModifyAddressPageParameterValue onGetModifyAddressPageParameterValue;
  _OnGetModifyAddressInput<String> onGetNameModifyAddressInput;
  _OnGetModifyAddressInput<String> onGetEmailModifyAddressInput;
  _OnGetModifyAddressInput<String> onGetLabelModifyAddressInput;
  _OnGetModifyAddressInput<String> onGetAddressModifyAddressInput;
  _OnGetModifyAddressInput<String> onGetPhoneNumberModifyAddressInput;
  _OnGetModifyAddressInput<String> onGetZipCodeModifyAddressInput;
  _OnGetModifyAddressInput<Country?> onGetCountryModifyAddressInput;
  _OnGetModifyAddressInput<String> onGetCityModifyAddressInput;
  _OnGetModifyAddressInput<String> onGetStateModifyAddressInput;
  _OnModifyAddressBack onModifyAddressBack;
  _OnLoadSelectedAddressRequestProcessCallback onLoadSelectedAddressRequestProcessCallback;
  _OnShowModifyAddressRequestProcessLoadingCallback onShowModifyAddressRequestProcessLoadingCallback;
  _OnModifyAddressRequestProcessSuccessCallback onModifyAddressRequestProcessSuccessCallback;
  _OnShowModifyAddressRequestProcessFailedCallback onShowModifyAddressRequestProcessFailedCallback;

  ModifyAddressDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetModifyAddressPageParameterValue,
    required this.onGetNameModifyAddressInput,
    required this.onGetEmailModifyAddressInput,
    required this.onGetLabelModifyAddressInput,
    required this.onGetAddressModifyAddressInput,
    required this.onGetPhoneNumberModifyAddressInput,
    required this.onGetZipCodeModifyAddressInput,
    required this.onGetCountryModifyAddressInput,
    required this.onGetCityModifyAddressInput,
    required this.onGetStateModifyAddressInput,
    required this.onModifyAddressBack,
    required this.onLoadSelectedAddressRequestProcessCallback,
    required this.onShowModifyAddressRequestProcessLoadingCallback,
    required this.onModifyAddressRequestProcessSuccessCallback,
    required this.onShowModifyAddressRequestProcessFailedCallback
  });
}