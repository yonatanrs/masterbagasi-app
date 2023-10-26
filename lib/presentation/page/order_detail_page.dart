import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/presentation/page/web_viewer_page.dart';
import 'package:sizer/sizer.dart';

import '../../controller/order_detail_controller.dart';
import '../../domain/entity/order/order.dart';
import '../../domain/entity/order/order_based_id_parameter.dart';
import '../../domain/usecase/get_order_based_id_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/orderlistitemcontrollerstate/order_detail_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/date_util.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../widget/colorful_chip.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import 'getx_page.dart';

class OrderDetailPage extends RestorableGetxPage<_OrderDetailPageRestoration> {
  late final ControllerMember<OrderDetailController> _orderDetailController = ControllerMember<OrderDetailController>().addToControllerManager(controllerManager);

  final String orderId;

  OrderDetailPage({
    Key? key,
    required this.orderId
  }) : super(key: key, pageRestorationId: () => "order-detail-page");

  @override
  void onSetController() {
    _orderDetailController.controller = GetExtended.put<OrderDetailController>(
      OrderDetailController(
        controllerManager,
        Injector.locator<GetOrderBasedIdUseCase>()
      ),
      tag: pageName
    );
  }

  @override
  _OrderDetailPageRestoration createPageRestoration() => _OrderDetailPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulOrderDetailControllerMediatorWidget(
      orderDetailController: _orderDetailController.controller,
      orderId: orderId,
    );
  }
}

class _OrderDetailPageRestoration extends MixableGetxPageRestoration with WebViewerPageRestorationMixin {
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

class OrderDetailPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final String orderId;

  OrderDetailPageGetPageBuilderAssistant({
    required this.orderId
  });

  @override
  GetPageBuilder get pageBuilder => (() => OrderDetailPage(orderId: orderId));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(OrderDetailPage(orderId: orderId)));
}

mixin OrderDetailPageRestorationMixin on MixableGetxPageRestoration {
  late OrderDetailPageRestorableRouteFuture orderDetailPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    orderDetailPageRestorableRouteFuture = OrderDetailPageRestorableRouteFuture(restorationId: restorationIdWithPageName('order-detail-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    orderDetailPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    orderDetailPageRestorableRouteFuture.dispose();
  }
}

class OrderDetailPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  OrderDetailPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw Exception("Arguments must be a string");
    }
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        OrderDetailPageGetPageBuilderAssistant(
          orderId: arguments
        )
      ),
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _pageRouteBuilder(BuildContext context, Object? arguments) {
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

class _StatefulOrderDetailControllerMediatorWidget extends StatefulWidget {
  final OrderDetailController orderDetailController;
  final String orderId;

  const _StatefulOrderDetailControllerMediatorWidget({
    required this.orderDetailController,
    required this.orderId
  });

  @override
  State<_StatefulOrderDetailControllerMediatorWidget> createState() => _StatefulOrderDetailControllerMediatorWidgetState();
}

class _StatefulOrderDetailControllerMediatorWidgetState extends State<_StatefulOrderDetailControllerMediatorWidget> {
  late final ScrollController _orderDetailScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _orderDetailListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _orderDetailListItemPagingControllerState;

  @override
  void initState() {
    super.initState();
    _orderDetailScrollController = ScrollController();
    _orderDetailListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.orderDetailController.apiRequestManager,
    );
    _orderDetailListItemPagingControllerState = PagingControllerState(
      pagingController: _orderDetailListItemPagingController,
      scrollController: _orderDetailScrollController,
      isPagingControllerExist: false
    );
    _orderDetailListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _orderDetailListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _orderDetailListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _orderDetailListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? orderDetailListItemControllerStateList) async {
    LoadDataResult<Order> orderDetailLoadDataResult = await widget.orderDetailController.getOrderBasedId(
      OrderBasedIdParameter(orderId: widget.orderId)
    );
    return orderDetailLoadDataResult.map<PagingResult<ListItemControllerState>>((orderDetail) {
      return PagingDataResult<ListItemControllerState>(
        itemList: <ListItemControllerState>[
          OrderDetailContainerListItemControllerState(
            order: orderDetail,
            onUpdateState: () => setState(() {})
          )
        ],
        page: 1,
        totalPage: 1,
        totalItem: 1
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("Transaction Detail".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _orderDetailListItemPagingControllerState,
                onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
                  pagingControllerState: pagingControllerState!
                ),
                pullToRefresh: true
              ),
            ),
          ]
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}