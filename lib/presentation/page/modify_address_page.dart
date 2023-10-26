import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/error_provider_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/validation_result_ext.dart';
import 'package:sizer/sizer.dart';

import '../../controller/modify_address_controller.dart';
import '../../domain/entity/address/address.dart';
import '../../domain/entity/address/country.dart';
import '../../domain/usecase/add_address_use_case.dart';
import '../../domain/usecase/change_address_use_case.dart';
import '../../domain/usecase/get_address_based_id_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/error/message_error.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/inputdecoration/default_input_decoration.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/string_util.dart';
import '../../misc/validation/validator/validator.dart';
import '../../misc/widget_helper.dart';
import '../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../widget/field.dart';
import '../widget/loaddataresultimplementer/load_data_result_implementer.dart';
import '../widget/modified_loading_indicator.dart';
import '../widget/modified_text_field.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import '../widget/rx_consumer.dart';
import '../widget/select_country_indicator.dart';
import 'getx_page.dart';

class ModifyAddressPage extends RestorableGetxPage<_ModifyAddressPageRestoration> {
  late final ControllerMember<ModifyAddressController> _modifyAddressController = ControllerMember<ModifyAddressController>().addToControllerManager(controllerManager);

  final ModifyAddressPageParameter modifyAddressPageParameter;

  ModifyAddressPage({
    Key? key,
    required this.modifyAddressPageParameter
  }) : super(
    key: key,
    pageRestorationId: () => "modify-address-page"
  );

  @override
  void onSetController() {
    _modifyAddressController.controller = GetExtended.put<ModifyAddressController>(
      ModifyAddressController(
        controllerManager,
        Injector.locator<AddAddressUseCase>(),
        Injector.locator<ChangeAddressUseCase>(),
        Injector.locator<GetAddressBasedIdUseCase>()
      ), tag: pageName
    );
  }

  @override
  _ModifyAddressPageRestoration createPageRestoration() => _ModifyAddressPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulModifyAddressControllerMediatorWidget(
        modifyAddressController: _modifyAddressController.controller,
        modifyAddressPageParameter: modifyAddressPageParameter,
      ),
    );
  }
}

class _ModifyAddressPageRestoration extends MixableGetxPageRestoration {
  @override
  // ignore: unnecessary_overrides
  void initState() {
    super.initState();
  }

  @override
  // ignore: unnecessary_overrides
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  // ignore: unnecessary_overrides
  void dispose() {
    super.dispose();
  }
}

class ModifyAddressPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final ModifyAddressPageParameter modifyAddressPageParameter;

  ModifyAddressPageGetPageBuilderAssistant({
    required this.modifyAddressPageParameter
  });

  @override
  GetPageBuilder get pageBuilder => (() => ModifyAddressPage(modifyAddressPageParameter: modifyAddressPageParameter));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(ModifyAddressPage(modifyAddressPageParameter: modifyAddressPageParameter)));
}

mixin ModifyAddressPageRestorationMixin on MixableGetxPageRestoration {
  RouteCompletionCallback<bool?>? onCompleteModifyAddress;

  late ModifyAddressPageRestorableRouteFuture modifyAddressPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    modifyAddressPageRestorableRouteFuture = ModifyAddressPageRestorableRouteFuture(
      restorationId: restorationIdWithPageName('modify-address-route'),
      onComplete: onCompleteModifyAddress
    );
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    modifyAddressPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    modifyAddressPageRestorableRouteFuture.dispose();
  }
}

class ModifyAddressPageRestorableRouteFuture extends GetRestorableRouteFuture {
  final RouteCompletionCallback<bool?>? onComplete;

  late RestorableRouteFuture<bool?> _pageRoute;

  ModifyAddressPageRestorableRouteFuture({
    required String restorationId,
    this.onComplete
  }) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<bool?>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
      onComplete: onComplete
    );
  }

  static Route<bool?>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw MessageError(message: "Arguments must be a String");
    }
    ModifyAddressPageParameter modifyAddressPageParameter = arguments.toModifyAddressPageParameter();
    return GetExtended.toWithGetPageRouteReturnValue<bool?>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        ModifyAddressPageGetPageBuilderAssistant(
          modifyAddressPageParameter: modifyAddressPageParameter
        )
      )
    );
  }

  @pragma('vm:entry-point')
  static Route<bool?> _pageRouteBuilder(BuildContext context, Object? arguments) {
    return _getRoute(arguments)!;
  }

  @override
  bool checkBeforePresent([Object? arguments]) => _getRoute(arguments) != null;

  @override
  void presentIfCheckIsPassed([Object? arguments]) => _pageRoute.present(arguments);

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    restorator.registerForRestoration(_pageRoute, restorationId);
  }

  @override
  void dispose() {
    _pageRoute.dispose();
  }
}

class _StatefulModifyAddressControllerMediatorWidget extends StatefulWidget {
  final ModifyAddressController modifyAddressController;
  final ModifyAddressPageParameter modifyAddressPageParameter;

  const _StatefulModifyAddressControllerMediatorWidget({
    required this.modifyAddressController,
    required this.modifyAddressPageParameter
  });

  @override
  State<_StatefulModifyAddressControllerMediatorWidget> createState() => _StatefulModifyAddressControllerMediatorWidgetState();
}

class _StatefulModifyAddressControllerMediatorWidgetState extends State<_StatefulModifyAddressControllerMediatorWidget> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _labelTextEditingController = TextEditingController();
  final TextEditingController _addressTextEditingController = TextEditingController();
  final TextEditingController _phoneTextEditingController = TextEditingController();
  final TextEditingController _zipCodeTextEditingController = TextEditingController();
  Country? _selectedCountry;
  final TextEditingController _cityTextEditingController = TextEditingController();
  final TextEditingController _stateTextEditingController = TextEditingController();
  dynamic _failedModifyAddressError;
  LoadDataResult<Address> _addressLoadDataResult = NoLoadDataResult<Address>();

  @override
  Widget build(BuildContext context) {
    widget.modifyAddressController.setModifyAddressDelegate(
      ModifyAddressDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onGetModifyAddressPageParameterValue: () => widget.modifyAddressPageParameter.modifyAddressPageParameterValue,
        onLoadSelectedAddressRequestProcessCallback: (addressLoadDataResult) async {
          if (addressLoadDataResult.isSuccess) {
            Address address = addressLoadDataResult.resultIfSuccess!;
            _nameTextEditingController.text = address.name;
            _emailTextEditingController.text = address.email;
            _labelTextEditingController.text = address.label;
            _addressTextEditingController.text = address.address;
            _phoneTextEditingController.text = address.phoneNumber;
            _zipCodeTextEditingController.text = address.zipCode;
            _selectedCountry = address.country;
            _cityTextEditingController.text = address.city;
            _stateTextEditingController.text = address.state;
          }
          setState(() => _addressLoadDataResult = addressLoadDataResult);
        },
        onGetNameModifyAddressInput: () => _nameTextEditingController.text,
        onGetEmailModifyAddressInput: () => _emailTextEditingController.text,
        onGetLabelModifyAddressInput: () => _labelTextEditingController.text,
        onGetAddressModifyAddressInput: () => _addressTextEditingController.text,
        onGetPhoneNumberModifyAddressInput: () => _phoneTextEditingController.text,
        onGetZipCodeModifyAddressInput: () => _zipCodeTextEditingController.text,
        onGetCountryModifyAddressInput: () => _selectedCountry,
        onGetCityModifyAddressInput: () => _cityTextEditingController.text,
        onGetStateModifyAddressInput: () => _stateTextEditingController.text,
        onModifyAddressBack: () => Get.back(),
        onShowModifyAddressRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowModifyAddressRequestProcessFailedCallback: (e) async {
          setState(() => _failedModifyAddressError = e);
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _scrollController.jumpTo(0);
          });
        },
        onModifyAddressRequestProcessSuccessCallback: () async {
          Get.back(result: true);
        },
      )
    );
    ModifyAddressPageParameterValue? modifyAddressPageParameterValue = widget.modifyAddressPageParameter.modifyAddressPageParameterValue;
    if (modifyAddressPageParameterValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.modifyAddressController.loadAddress();
      });
    }
    Widget modifyAddressBody = NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_failedModifyAddressError != null)
              ...[
                Builder(
                  builder: (context) {
                    ErrorProviderResult errorProviderResult = Injector.locator<ErrorProvider>()
                      .onGetErrorProviderResult(_failedModifyAddressError)
                      .toErrorProviderResultNonNull();
                    return Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          errorProviderResult.message,
                          style: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Constant.colorRedDanger
                      ),
                    );
                  }
                ),
                const SizedBox(height: 20),
              ],
            Text("Email".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.emailValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _emailTextEditingController,
                  decoration: const DefaultInputDecoration(),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Name".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.nameValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _nameTextEditingController,
                  decoration: const DefaultInputDecoration(),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Label".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.labelValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _labelTextEditingController,
                  decoration: const DefaultInputDecoration(),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Address".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.addressValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _addressTextEditingController,
                  decoration: const DefaultInputDecoration(),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Phone Number".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.phoneNumberValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _phoneTextEditingController,
                  decoration: const DefaultInputDecoration(),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Zip Code".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.zipCodeValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _zipCodeTextEditingController,
                  decoration: const DefaultInputDecoration(),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("Country".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.countryValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => SelectCountryIndicator(
                  selectedCountry: _selectedCountry,
                  onSelectCountry: (country) {
                    setState(() => _selectedCountry = country);
                  }
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("City".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.cityValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _cityTextEditingController,
                  decoration: const DefaultInputDecoration(),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.next,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            Text("State".tr),
            const SizedBox(height: 10),
            RxConsumer<Validator>(
              rxValue: widget.modifyAddressController.stateValidatorRx,
              onConsumeValue: (context, value) => Field(
                child: (context, validationResult, validator) => ModifiedTextField(
                  isError: validationResult.isFailed,
                  controller: _stateTextEditingController,
                  decoration: const DefaultInputDecoration(),
                  onChanged: (value) => validator?.validate(),
                  textInputAction: TextInputAction.done,
                ),
                validator: value,
              ),
            ),
            const SizedBox(height: 20),
            SizedOutlineGradientButton(
              width: double.infinity,
              onPressed: widget.modifyAddressController.submit,
              text: "Submit".tr,
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text(modifyAddressPageParameterValue == null ? "Create Address".tr : "Change Address".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: LoadDataResultImplementer<Address>(
          loadDataResult: _addressLoadDataResult,
          errorProvider: Injector.locator<ErrorProvider>(),
          onNoLoadingLoadDataResultWidget: () => modifyAddressBody,
          onSuccessLoadDataResultWidget: (address) => modifyAddressBody,
          onFailedLoadDataResultWidget: (errorProviderOutput, e, defaultWidget) {
            return Center(
              child: WidgetHelper.buildFailedPromptIndicatorFromErrorProvider(
                context: context,
                errorProvider: errorProviderOutput,
                e: e,
                buttonText: "Reload".tr,
                onPressed: widget.modifyAddressController.reloadAddress
              )
            );
          }
        )
      )
    );
  }
}

class ModifyAddressPageParameter {
  ModifyAddressPageParameterValue? modifyAddressPageParameterValue;

  ModifyAddressPageParameter({
    this.modifyAddressPageParameterValue
  });
}

class ModifyAddressPageParameterValue {
  String addressId;

  ModifyAddressPageParameterValue({
    required this.addressId
  });
}

extension AddressToModifyAddressExt on Address {
  ModifyAddressPageParameterValue toModifyAddressPageParameterValue() {
    return ModifyAddressPageParameterValue(
      addressId: id
    );
  }
}

extension ModifyAddressPageParameterExt on ModifyAddressPageParameter {
  String toEncodeBase64String() => StringUtil.encodeBase64StringFromJson(
    <String, dynamic>{
      if (modifyAddressPageParameterValue != null)
        "modify_address_parameter": <String, dynamic>{
          "address_id": modifyAddressPageParameterValue!.addressId
        }
    }
  );
}

extension ModifyAddressPageParameterStringExt on String {
  ModifyAddressPageParameter toModifyAddressPageParameter() {
    dynamic result = StringUtil.decodeBase64StringToJson(this);
    dynamic addressResult = result["modify_address_parameter"];
    ModifyAddressPageParameterValue? modifyAddressPageParameterValue;
    if (addressResult != null) {
      modifyAddressPageParameterValue = ModifyAddressPageParameterValue(
        addressId: addressResult["address_id"]
      );
    }
    return ModifyAddressPageParameter(
      modifyAddressPageParameterValue: modifyAddressPageParameterValue
    );
  }
}