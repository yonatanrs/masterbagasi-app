import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../../../controller/deliveryreviewcontroller/deliveryreviewsubpagecontroller/waiting_to_be_reviewed_delivery_review_sub_controller.dart';
import '../../../../domain/entity/delivery/delivery_review.dart';
import '../../../../domain/entity/delivery/delivery_review_paging_parameter.dart';
import '../../../../domain/entity/user/user.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/waiting_to_be_reviewed_delivery_review_detail_container_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/load_data_result_dynamic_list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/no_content_list_item_controller_state.dart';
import '../../../../misc/controllerstate/paging_controller_state.dart';
import '../../../../misc/dialog_helper.dart';
import '../../../../misc/entityandlistitemcontrollerstatemediator/horizontal_component_entity_parameterized_entity_and_list_item_controller_state_mediator.dart';
import '../../../../misc/errorprovider/error_provider.dart';
import '../../../../misc/injector.dart';
import '../../../../misc/itemtypelistsubinterceptor/delivery_review_item_type_list_sub_interceptor.dart';
import '../../../../misc/list_item_controller_state_helper.dart';
import '../../../../misc/load_data_result.dart';
import '../../../../misc/main_route_observer.dart';
import '../../../../misc/manager/controller_manager.dart';
import '../../../../misc/paging/modified_paging_controller.dart';
import '../../../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../../misc/paging/pagingresult/paging_result.dart';
import '../../../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/horizontal_dynamic_item_carousel_parametered_component_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../../../widget/modified_paged_list_view.dart';
import '../../getx_page.dart';
import '../../modaldialogpage/check_your_contribution_delivery_review_detail_modal_dialog_page.dart';
import '../../modaldialogpage/give_review_delivery_review_detail_modal_dialog_page.dart';

class WaitingToBeReviewedDeliveryReviewSubPage extends DefaultGetxPage {
  late final ControllerMember<WaitingToBeReviewedDeliveryReviewSubController> _waitingToBeReviewedDeliveryReviewSubController;
  final String ancestorPageName;
  final ControllerMember<WaitingToBeReviewedDeliveryReviewSubController> Function() onAddControllerMember;

  WaitingToBeReviewedDeliveryReviewSubPage({
    Key? key,
    required this.ancestorPageName,
    required this.onAddControllerMember
  }) : super(key: key) {
    _waitingToBeReviewedDeliveryReviewSubController = onAddControllerMember();
  }

  @override
  void onSetController() {
    _waitingToBeReviewedDeliveryReviewSubController.controller = Injector.locator<WaitingToBeReviewedDeliveryReviewSubControllerInjectionFactory>().inject(controllerManager, ancestorPageName);
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulWaitingToBeReviewedDeliveryReviewSubControllerMediatorWidget(
      waitingToBeReviewedDeliveryReviewSubController: _waitingToBeReviewedDeliveryReviewSubController.controller
    );
  }
}

class _StatefulWaitingToBeReviewedDeliveryReviewSubControllerMediatorWidget extends StatefulWidget {
  final WaitingToBeReviewedDeliveryReviewSubController waitingToBeReviewedDeliveryReviewSubController;

  const _StatefulWaitingToBeReviewedDeliveryReviewSubControllerMediatorWidget({
    required this.waitingToBeReviewedDeliveryReviewSubController
  });

  @override
  State<_StatefulWaitingToBeReviewedDeliveryReviewSubControllerMediatorWidget> createState() => _StatefulWaitingToBeReviewedDeliveryReviewSubControllerMediatorWidgetState();
}

class _StatefulWaitingToBeReviewedDeliveryReviewSubControllerMediatorWidgetState extends State<_StatefulWaitingToBeReviewedDeliveryReviewSubControllerMediatorWidget> {
  late final ScrollController _waitingToBeReviewedDeliveryScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _waitingToBeReviewedDeliveryReviewSubListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _waitingToBeReviewedDeliveryReviewSubListItemPagingControllerState;
  final WaitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState _waitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState = DefaultWaitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState();
  final List<BaseLoadDataResultDynamicListItemControllerState> _dynamicItemLoadDataResultDynamicListItemControllerStateList = [];

  @override
  void initState() {
    super.initState();
    _waitingToBeReviewedDeliveryScrollController = ScrollController();
    _waitingToBeReviewedDeliveryReviewSubListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.waitingToBeReviewedDeliveryReviewSubController.apiRequestManager,
    );
    _waitingToBeReviewedDeliveryReviewSubListItemPagingControllerState = PagingControllerState(
      pagingController: _waitingToBeReviewedDeliveryReviewSubListItemPagingController,
      scrollController: _waitingToBeReviewedDeliveryScrollController,
      isPagingControllerExist: false
    );
    _waitingToBeReviewedDeliveryReviewSubListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _waitingToBeReviewedDeliveryReviewListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _waitingToBeReviewedDeliveryReviewSubListItemPagingControllerState.isPagingControllerExist = true;
    MainRouteObserver.onRefreshDeliveryReview?.onRefreshWaitingToBeReviewedDeliveryReview = () => _waitingToBeReviewedDeliveryReviewSubListItemPagingController.refresh();
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _waitingToBeReviewedDeliveryReviewListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? orderListItemControllerStateList) async {
    HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator componentEntityMediator = Injector.locator<HorizontalComponentEntityParameterizedEntityAndListItemControllerStateMediator>();
    HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter carouselParameterizedEntityMediator = HorizontalDynamicItemCarouselParameterizedEntityAndListItemControllerStateMediatorParameter(
      onSetState: () => setState(() {}),
      dynamicItemLoadDataResultDynamicListItemControllerStateList: _dynamicItemLoadDataResultDynamicListItemControllerStateList
    );
    _dynamicItemLoadDataResultDynamicListItemControllerStateList.clear();
    LoadDataResult<PagingDataResult<DeliveryReview>> deliveryReviewPagingLoadDataResult = await widget.waitingToBeReviewedDeliveryReviewSubController.getWaitingToBeReviewedDeliveryReviewPaging(
      DeliveryReviewPagingParameter(page: pageKey)
    );
    return deliveryReviewPagingLoadDataResult.map<PagingResult<ListItemControllerState>>((deliveryReviewPaging) {
      List<ListItemControllerState> resultListItemControllerState = [];
      int totalItem = deliveryReviewPaging.totalItem;
      if (pageKey == 1) {
        totalItem = 1;
        resultListItemControllerState = [
          WaitingToBeReviewedDeliveryReviewDetailContainerListItemControllerState(
            deliveryReviewList: deliveryReviewPaging.itemList,
            onUpdateState: () => setState(() {}),
            errorProvider: Injector.locator<ErrorProvider>(),
            waitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState: _waitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState,
            waitingToBeReviewedDeliveryReviewDetailContainerStorageListItemControllerState: DefaultWaitingToBeReviewedDeliveryReviewDetailContainerStorageListItemControllerState(),
            onWaitingToBeReviewedDeliveryReviewTap: (deliveryReview, selectedRating) async {
              dynamic result = await DialogHelper.showModalBottomDialogPage<bool, GiveReviewDeliveryReviewDetailModalDialogPageParameter>(
                context: context,
                modalDialogPageBuilder: (context, parameter) => GiveReviewDeliveryReviewDetailModalDialogPage(
                  selectedRating: selectedRating,
                  deliveryReview: deliveryReview,
                ),
                parameter: GiveReviewDeliveryReviewDetailModalDialogPageParameter(
                  selectedRating: selectedRating,
                  deliveryReview: deliveryReview
                )
              );
              if (result is bool) {
                MainRouteObserver.onRefreshDeliveryReview?.refresh();
              }
            },
            onTapCheckYourContribution: () async {
              await DialogHelper.showModalBottomDialogPage<bool, String>(
                context: context,
                modalDialogPageBuilder: (context, parameter) => CheckYourContributionDeliveryReviewDetailModalDialogPage(),
              );
            },
            getCheckYourContributionDeliveryReviewDetailListItemControllerState: () => componentEntityMediator.mapWithParameter(
              widget.waitingToBeReviewedDeliveryReviewSubController.getUserProfile(),
              parameter: carouselParameterizedEntityMediator
            ),
          )
        ];
      } else {
        if (ListItemControllerStateHelper.checkListItemControllerStateList(orderListItemControllerStateList)) {
          WaitingToBeReviewedDeliveryReviewDetailContainerListItemControllerState waitingToBeReviewedDeliveryReviewDetailContainerListItemControllerState = ListItemControllerStateHelper.parsePageKeyedListItemControllerState(orderListItemControllerStateList![0]) as WaitingToBeReviewedDeliveryReviewDetailContainerListItemControllerState;
          waitingToBeReviewedDeliveryReviewDetailContainerListItemControllerState.deliveryReviewList.addAll(deliveryReviewPaging.itemList);
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
    widget.waitingToBeReviewedDeliveryReviewSubController.setWaitingToBeReviewedDeliveryReviewSubDelegate(
      WaitingToBeReviewedDeliveryReviewSubDelegate(
        onObserveLoadUserDirectly: (onObserveLoadUserDirectlyParameter) {
          ListItemControllerState Function(LoadDataResult<User>)? onImplementUserLoadDataResult = _waitingToBeReviewedDeliveryReviewDetailContainerInterceptingActionListItemControllerState.onImplementUserLoadDataResult;
          if (onImplementUserLoadDataResult != null) {
            return onImplementUserLoadDataResult(onObserveLoadUserDirectlyParameter.userLoadDataResult);
          } else {
            return NoContentListItemControllerState();
          }
        }
      )
    );
    return Column(
      children: [
        Expanded(
          child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
            pagingControllerState: _waitingToBeReviewedDeliveryReviewSubListItemPagingControllerState,
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