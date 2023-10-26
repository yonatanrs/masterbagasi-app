import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../controller/order_chat_controller.dart';
import '../../domain/entity/chat/order/get_order_message_by_user_parameter.dart';
import '../../domain/entity/chat/order/get_order_message_by_user_response.dart';
import '../../domain/usecase/answer_order_conversation_use_case.dart';
import '../../domain/usecase/create_order_conversation_use_case.dart';
import '../../domain/usecase/get_order_message_by_user_use_case.dart';
import '../../domain/usecase/get_user_use_case.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import 'getx_page.dart';

class OrderChatPage extends RestorableGetxPage<_OrderChatPageRestoration> {
  late final ControllerMember<OrderChatController> _orderChatController = ControllerMember<OrderChatController>().addToControllerManager(controllerManager);

  OrderChatPage({Key? key}) : super(key: key, pageRestorationId: () => "order-chat-page");

  @override
  void onSetController() {
    _orderChatController.controller = GetExtended.put<OrderChatController>(
      OrderChatController(
        controllerManager,
        Injector.locator<GetOrderMessageByUserUseCase>(),
        Injector.locator<CreateOrderConversationUseCase>(),
        Injector.locator<AnswerOrderConversationUseCase>(),
        Injector.locator<GetUserUseCase>(),
      ),
      tag: pageName
    );
  }

  @override
  _OrderChatPageRestoration createPageRestoration() => _OrderChatPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulOrderChatControllerMediatorWidget(
        orderChatController: _orderChatController.controller,
      ),
    );
  }
}

class _OrderChatPageRestoration extends MixableGetxPageRestoration with OrderChatPageRestorationMixin {
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

class OrderChatPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => OrderChatPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(OrderChatPage()));
}

mixin OrderChatPageRestorationMixin on MixableGetxPageRestoration {
  late OrderChatPageRestorableRouteFuture orderChatPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    orderChatPageRestorableRouteFuture = OrderChatPageRestorableRouteFuture(restorationId: restorationIdWithPageName('order-chat-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    orderChatPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    orderChatPageRestorableRouteFuture.dispose();
  }
}

class OrderChatPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  OrderChatPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(OrderChatPageGetPageBuilderAssistant())
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

class _StatefulOrderChatControllerMediatorWidget extends StatefulWidget {
  final OrderChatController orderChatController;

  const _StatefulOrderChatControllerMediatorWidget({
    required this.orderChatController
  });

  @override
  State<_StatefulOrderChatControllerMediatorWidget> createState() => _StatefulOrderChatControllerMediatorWidgetState();
}

class _StatefulOrderChatControllerMediatorWidgetState extends State<_StatefulOrderChatControllerMediatorWidget> {
  late final ScrollController _orderChatScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _orderChatListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _orderChatListItemPagingControllerState;

  @override
  void initState() {
    super.initState();
    _orderChatScrollController = ScrollController();
    _orderChatListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.orderChatController.apiRequestManager
    );
    _orderChatListItemPagingControllerState = PagingControllerState(
      pagingController: _orderChatListItemPagingController,
      isPagingControllerExist: false
    );
    _orderChatListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _helpChatListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _orderChatListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _helpChatListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    LoadDataResult<GetOrderMessageByUserResponse> getOrderMessageByUserResponseLoadDataResult = await widget.orderChatController.getOrderMessageByUser(
      GetOrderMessageByUserParameter()
    );
    return getOrderMessageByUserResponseLoadDataResult.map<PagingResult<ListItemControllerState>>((getHelpMessageByUserResponse) {
      return PagingDataResult<ListItemControllerState>(
        itemList: [],
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
            Text("Order Chat".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _orderChatListItemPagingControllerState,
                onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
                  pagingControllerState: pagingControllerState!
                ),
                pullToRefresh: true
              ),
            )
          ]
        )
      ),
    );
  }
}