import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../../controller/modaldialogcontroller/select_countries_modal_dialog_controller.dart';
import '../../../domain/entity/address/country.dart';
import '../../../domain/entity/address/country_paging_parameter.dart';
import '../../../domain/usecase/get_country_paging_use_case.dart';
import '../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../misc/controllerstate/listitemcontrollerstate/selectcountrieslistitemcontrollerstate/country_container_list_item_controller_state.dart';
import '../../../misc/controllerstate/paging_controller_state.dart';
import '../../../misc/injector.dart';
import '../../../misc/list_item_controller_state_helper.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/paging/modified_paging_controller.dart';
import '../../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/paging/pagingresult/paging_result.dart';
import '../../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../../widget/modified_paged_list_view.dart';
import '../../widget/modifiedappbar/modified_app_bar.dart';
import 'modal_dialog_page.dart';

class SelectCountriesModalDialogPage extends ModalDialogPage<SelectCountriesModalDialogController> {
  SelectCountriesModalDialogController get selectCountriesModalDialogController => modalDialogController.controller;

  final Country? selectedCountry;

  SelectCountriesModalDialogPage({
    Key? key,
    required this.selectedCountry
  }) : super(key: key);

  @override
  SelectCountriesModalDialogController onCreateModalDialogController() {
    return SelectCountriesModalDialogController(
      controllerManager,
      Injector.locator<GetCountryPagingUseCase>()
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulSelectCountriesControllerMediatorWidget(
      selectCountriesModalDialogController: selectCountriesModalDialogController,
      selectedCountry: selectedCountry
    );
  }
}

class _StatefulSelectCountriesControllerMediatorWidget extends StatefulWidget {
  final SelectCountriesModalDialogController selectCountriesModalDialogController;
  final Country? selectedCountry;

  const _StatefulSelectCountriesControllerMediatorWidget({
    required this.selectCountriesModalDialogController,
    required this.selectedCountry
  });

  @override
  State<_StatefulSelectCountriesControllerMediatorWidget> createState() => _StatefulCheckRatesForVariousCountriesControllerMediatorWidgetState();
}

class _StatefulCheckRatesForVariousCountriesControllerMediatorWidgetState extends State<_StatefulSelectCountriesControllerMediatorWidget> {
  late final ScrollController _selectCountriesScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _selectCountriesListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _selectCountriesListItemPagingControllerState;
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectCountriesScrollController = ScrollController();
    _selectCountriesListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.selectCountriesModalDialogController.apiRequestManager,
    );
    _selectCountriesListItemPagingControllerState = PagingControllerState(
      pagingController: _selectCountriesListItemPagingController,
      scrollController: _selectCountriesScrollController,
      isPagingControllerExist: false
    );
    _selectCountriesListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _selectCountriesListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _selectCountriesListItemPagingControllerState.isPagingControllerExist = true;
    _selectedCountry = widget.selectedCountry;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _selectCountriesListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    LoadDataResult<PagingDataResult<Country>> countryPagingDataResult = await widget.selectCountriesModalDialogController.getCountryPaging(
      CountryPagingParameter(page: pageKey)
    );
    return countryPagingDataResult.map<PagingResult<ListItemControllerState>>((countryPaging) {
      List<ListItemControllerState> resultListItemControllerState = [];
      int totalItem = countryPaging.totalItem;
      if (pageKey == 1) {
        totalItem = 2;
        resultListItemControllerState.add(
          CountryContainerListItemControllerState(
            country: countryPaging.itemList,
            onSelectCountry: (country) {
              setState(() {
                _selectedCountry = country;
              });
            },
            onGetSelectCountry: () => _selectedCountry,
            onUpdateState: () => setState(() {})
          )
        );
      } else {
        if (ListItemControllerStateHelper.checkListItemControllerStateList(listItemControllerStateList)) {
          CountryContainerListItemControllerState countryContainerListItemControllerState = ListItemControllerStateHelper.parsePageKeyedListItemControllerState(listItemControllerStateList![0]) as CountryContainerListItemControllerState;
          countryContainerListItemControllerState.country.addAll(countryPaging.itemList);
        }
      }
      return PagingDataResult<ListItemControllerState>(
        itemList: resultListItemControllerState,
        page: countryPaging.page,
        totalPage: countryPaging.totalPage,
        totalItem: totalItem
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ModifiedAppBar(
          titleInterceptor: (context, title) => Row(
            children: [
              Text("Select Country".tr),
            ],
          ),
        ),
        Expanded(
          child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
            pagingControllerState: _selectCountriesListItemPagingControllerState,
            onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
              pagingControllerState: pagingControllerState!
            ),
            pullToRefresh: true
          ),
        ),
        if (_selectedCountry != null)
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedOutlineGradientButton(
                  onPressed: () => Get.back(result: _selectedCountry),
                  text: "Choose Country".tr,
                  outlineGradientButtonType: OutlineGradientButtonType.solid,
                  outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                )
              ]
            ),
          )
      ]
    );
  }
}