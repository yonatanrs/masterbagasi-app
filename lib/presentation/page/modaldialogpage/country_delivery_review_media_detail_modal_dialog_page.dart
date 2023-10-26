import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../../controller/modaldialogcontroller/country_delivery_review_media_detail_modal_dialog_controller.dart';
import '../../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../../misc/controllerstate/listitemcontrollerstate/countrydeliveryreviewlistitemcontrollerstate/country_delivery_review_media_detail_list_item_controller_state.dart';
import '../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../misc/controllerstate/paging_controller_state.dart';
import '../../../misc/load_data_result.dart';
import '../../../misc/paging/modified_paging_controller.dart';
import '../../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../misc/paging/pagingresult/paging_result.dart';
import '../../widget/modified_paged_list_view.dart';
import '../../widget/modifiedappbar/modified_app_bar.dart';
import 'modal_dialog_page.dart';

class CountryDeliveryReviewMediaDetailModalDialogPage extends ModalDialogPage<CountryDeliveryReviewMediaDetailModalDialogController> {
  CountryDeliveryReviewMediaDetailModalDialogController get countryDeliveryReviewMediaDetailModalDialogController => modalDialogController.controller;

  final List<CountryDeliveryReviewMedia> countryDeliveryReviewMediaList;
  final BuildContext Function()? contextForOpeningMediaView;

  CountryDeliveryReviewMediaDetailModalDialogPage({
    super.key,
    required this.countryDeliveryReviewMediaList,
    this.contextForOpeningMediaView
  });

  @override
  CountryDeliveryReviewMediaDetailModalDialogController onCreateModalDialogController() {
    return CountryDeliveryReviewMediaDetailModalDialogController(
      controllerManager
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulCountryDeliveryReviewMediaDetailModalDialogControllerMediatorWidget(
      countryDeliveryReviewMediaDetailModalDialogController: countryDeliveryReviewMediaDetailModalDialogController,
      countryDeliveryReviewMediaList: countryDeliveryReviewMediaList,
      contextForOpeningMediaView: contextForOpeningMediaView
    );
  }
}

class _StatefulCountryDeliveryReviewMediaDetailModalDialogControllerMediatorWidget extends StatefulWidget {
  final CountryDeliveryReviewMediaDetailModalDialogController countryDeliveryReviewMediaDetailModalDialogController;
  final List<CountryDeliveryReviewMedia> countryDeliveryReviewMediaList;
  final BuildContext Function()? contextForOpeningMediaView;

  const _StatefulCountryDeliveryReviewMediaDetailModalDialogControllerMediatorWidget({
    required this.countryDeliveryReviewMediaDetailModalDialogController,
    required this.countryDeliveryReviewMediaList,
    required this.contextForOpeningMediaView
  });

  @override
  State<_StatefulCountryDeliveryReviewMediaDetailModalDialogControllerMediatorWidget> createState() => _StatefulCountryDeliveryReviewMediaDetailModalDialogControllerMediatorWidgetState();
}

class _StatefulCountryDeliveryReviewMediaDetailModalDialogControllerMediatorWidgetState extends State<_StatefulCountryDeliveryReviewMediaDetailModalDialogControllerMediatorWidget> {
  late final ScrollController _countryDeliveryReviewMediaDetailScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _countryDeliveryReviewMediaDetailPagingController;
  late final PagingControllerState<int, ListItemControllerState>_countryDeliveryReviewMediaDetailListItemPagingControllerState;

  @override
  void initState() {
    super.initState();
    _countryDeliveryReviewMediaDetailScrollController = ScrollController();
    _countryDeliveryReviewMediaDetailPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.countryDeliveryReviewMediaDetailModalDialogController.apiRequestManager,
    );
    _countryDeliveryReviewMediaDetailListItemPagingControllerState = PagingControllerState(
      pagingController: _countryDeliveryReviewMediaDetailPagingController,
      scrollController: _countryDeliveryReviewMediaDetailScrollController,
      isPagingControllerExist: false
    );
    _countryDeliveryReviewMediaDetailListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _countryDeliveryReviewMediaDetailListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _countryDeliveryReviewMediaDetailListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _countryDeliveryReviewMediaDetailListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    return SuccessLoadDataResult<PagingResult<ListItemControllerState>>(
      value: PagingDataResult<ListItemControllerState>(
        itemList: widget.countryDeliveryReviewMediaList.map<ListItemControllerState>(
          (countryDeliveryReviewMedia) => CountryDeliveryReviewMediaDetailListItemControllerState(
            countryDeliveryReviewMedia: countryDeliveryReviewMedia,
            contextForOpeningMediaView: widget.contextForOpeningMediaView
          )
        ).toList(),
        page: 1,
        totalPage: 1,
        totalItem: widget.countryDeliveryReviewMediaList.length
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ModifiedAppBar(
          titleInterceptor: (context, title) => Container(),
        ),
        Expanded(
          child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
            pagingControllerState: _countryDeliveryReviewMediaDetailListItemPagingControllerState,
            onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
              pagingControllerState: pagingControllerState!
            ),
            pullToRefresh: true
          ),
        ),
      ]
    );
  }
}