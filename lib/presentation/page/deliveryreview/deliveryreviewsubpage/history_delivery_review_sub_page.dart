import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../../../controller/deliveryreviewcontroller/deliveryreviewsubpagecontroller/history_delivery_review_sub_controller.dart';
import '../../../../domain/entity/delivery/delivery_review.dart';
import '../../../../domain/entity/delivery/delivery_review_paging_parameter.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/history_delivery_review_detail_container_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../../misc/controllerstate/paging_controller_state.dart';
import '../../../../misc/injector.dart';
import '../../../../misc/list_item_controller_state_helper.dart';
import '../../../../misc/load_data_result.dart';
import '../../../../misc/main_route_observer.dart';
import '../../../../misc/manager/controller_manager.dart';
import '../../../../misc/paging/modified_paging_controller.dart';
import '../../../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../../misc/paging/pagingresult/paging_result.dart';
import '../../../widget/modified_paged_list_view.dart';
import '../../getx_page.dart';

class HistoryDeliveryReviewSubPage extends DefaultGetxPage {
  late final ControllerMember<HistoryDeliveryReviewSubController> _historyDeliveryReviewSubController;
  final String ancestorPageName;
  final ControllerMember<HistoryDeliveryReviewSubController> Function() onAddControllerMember;

  HistoryDeliveryReviewSubPage({
    Key? key,
    required this.ancestorPageName,
    required this.onAddControllerMember
  }) : super(key: key) {
    _historyDeliveryReviewSubController = onAddControllerMember();
  }

  @override
  void onSetController() {
    _historyDeliveryReviewSubController.controller = Injector.locator<HistoryDeliveryReviewSubControllerInjectionFactory>().inject(controllerManager, ancestorPageName);
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulHistoryDeliveryReviewSubControllerMediatorWidget(
      historyDeliveryReviewSubController: _historyDeliveryReviewSubController.controller
    );
  }
}

class _StatefulHistoryDeliveryReviewSubControllerMediatorWidget extends StatefulWidget {
  final HistoryDeliveryReviewSubController historyDeliveryReviewSubController;

  const _StatefulHistoryDeliveryReviewSubControllerMediatorWidget({
    required this.historyDeliveryReviewSubController
  });

  @override
  State<_StatefulHistoryDeliveryReviewSubControllerMediatorWidget> createState() => _StatefulHistoryDeliveryReviewSubControllerMediatorWidgetState();
}

class _StatefulHistoryDeliveryReviewSubControllerMediatorWidgetState extends State<_StatefulHistoryDeliveryReviewSubControllerMediatorWidget> {
  late final ScrollController _historyDeliveryScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _historyDeliveryReviewSubListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _historyDeliveryReviewSubListItemPagingControllerState;

  @override
  void initState() {
    super.initState();
    _historyDeliveryScrollController = ScrollController();
    _historyDeliveryReviewSubListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.historyDeliveryReviewSubController.apiRequestManager,
    );
    _historyDeliveryReviewSubListItemPagingControllerState = PagingControllerState(
      pagingController: _historyDeliveryReviewSubListItemPagingController,
      scrollController: _historyDeliveryScrollController,
      isPagingControllerExist: false
    );
    _historyDeliveryReviewSubListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _historyDeliveryReviewListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _historyDeliveryReviewSubListItemPagingControllerState.isPagingControllerExist = true;
    MainRouteObserver.onRefreshDeliveryReview?.onRefreshHistoryDeliveryReview = () => _historyDeliveryReviewSubListItemPagingController.refresh();
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _historyDeliveryReviewListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? orderListItemControllerStateList) async {
    LoadDataResult<PagingDataResult<DeliveryReview>> deliveryReviewPagingLoadDataResult = await widget.historyDeliveryReviewSubController.getHistoryDeliveryReviewPaging(
      DeliveryReviewPagingParameter(page: pageKey)
    );
    return deliveryReviewPagingLoadDataResult.map<PagingResult<ListItemControllerState>>((deliveryReviewPaging) {
      List<ListItemControllerState> resultListItemControllerState = [];
      int totalItem = deliveryReviewPaging.totalItem;
      if (pageKey == 1) {
        totalItem = 1;
        resultListItemControllerState = [
          HistoryDeliveryReviewDetailContainerListItemControllerState(
            deliveryReviewList: deliveryReviewPaging.itemList,
            onUpdateState: () => setState(() {})
          )
        ];
      } else {
        if (ListItemControllerStateHelper.checkListItemControllerStateList(orderListItemControllerStateList)) {
          HistoryDeliveryReviewDetailContainerListItemControllerState historyDeliveryReviewDetailContainerListItemControllerState = ListItemControllerStateHelper.parsePageKeyedListItemControllerState(orderListItemControllerStateList![0]) as HistoryDeliveryReviewDetailContainerListItemControllerState;
          historyDeliveryReviewDetailContainerListItemControllerState.deliveryReviewList.addAll(deliveryReviewPaging.itemList);
        }
      }
      return PagingDataResult<ListItemControllerState>(
        itemList: resultListItemControllerState,
        page: deliveryReviewPaging.page,
        totalPage: deliveryReviewPaging.totalPage,
        totalItem: totalItem
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
            pagingControllerState: _historyDeliveryReviewSubListItemPagingControllerState,
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