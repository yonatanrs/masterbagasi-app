import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/misc/ext/paging_ext.dart';
import '../../controller/coupon_controller.dart';
import '../../domain/entity/coupon/coupon.dart';
import '../../domain/entity/coupon/coupon_list_parameter.dart';
import '../../domain/entity/coupon/coupon_paging_parameter.dart';
import '../../domain/usecase/get_coupon_list_use_case.dart';
import '../../domain/usecase/get_coupon_paging_use_case.dart';
import '../../misc/additionalloadingindicatorchecker/coupon_additional_paging_result_parameter_checker.dart';
import '../../misc/constant.dart';
import '../../misc/controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/couponlistitemcontrollerstate/coupon_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/couponlistitemcontrollerstate/vertical_coupon_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/error/message_error.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/itemtypelistsubinterceptor/coupon_item_type_list_sub_interceptor.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../../misc/string_util.dart';
import '../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modifiedappbar/default_search_app_bar.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import 'getx_page.dart';

class CouponPage extends RestorableGetxPage<_CouponPageRestoration> {
  final String couponId;

  late final ControllerMember<CouponController> _couponController = ControllerMember<CouponController>().addToControllerManager(controllerManager);

  CouponPage({
    Key? key,
    required this.couponId
  }) : super(
    key: key,
    pageRestorationId: () => "coupon-page"
  );

  @override
  void onSetController() {
    _couponController.controller = GetExtended.put<CouponController>(
      CouponController(
        controllerManager,
        Injector.locator<GetCouponPagingUseCase>(),
        Injector.locator<GetCouponListUseCase>()
      ),
      tag: pageName
    );
  }

  @override
  _CouponPageRestoration createPageRestoration() => _CouponPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulCouponControllerMediatorWidget(
        couponController: _couponController.controller,
        couponId: couponId,
      ),
    );
  }
}

class _CouponPageRestoration extends MixableGetxPageRestoration with CouponPageRestorationMixin {
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

class CouponPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final String couponId;

  CouponPageGetPageBuilderAssistant({
    required this.couponId
  });

  @override
  GetPageBuilder get pageBuilder => (() => CouponPage(
    couponId: couponId
  ));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(
    CouponPage(
      couponId: couponId
    )
  ));
}

mixin CouponPageRestorationMixin on MixableGetxPageRestoration {
  RouteCompletionCallback<String?>? onCompleteSelectCoupon;

  late CouponPageRestorableRouteFuture couponPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    couponPageRestorableRouteFuture = CouponPageRestorableRouteFuture(
      restorationId: restorationIdWithPageName('coupon-route'),
      onComplete: onCompleteSelectCoupon
    );
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    couponPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    couponPageRestorableRouteFuture.dispose();
  }
}

class CouponPageRestorableRouteFuture extends GetRestorableRouteFuture {
  final RouteCompletionCallback<String?>? onComplete;

  late RestorableRouteFuture<void> _pageRoute;

  CouponPageRestorableRouteFuture({
    required String restorationId,
    this.onComplete
  }) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<String?>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
      onComplete: onComplete
    );
  }

  static Route<String?>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw MessageError(message: "Arguments must be a String");
    }
    return GetExtended.toWithGetPageRouteReturnValue<String?>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        CouponPageGetPageBuilderAssistant(
          couponId: arguments
        )
      ),
    );
  }

  @pragma('vm:entry-point')
  static Route<String?> _pageRouteBuilder(BuildContext context, Object? arguments) {
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

class _StatefulCouponControllerMediatorWidget extends StatefulWidget {
  final CouponController couponController;
  final String? couponId;

  const _StatefulCouponControllerMediatorWidget({
    required this.couponController,
    required this.couponId
  });

  @override
  State<_StatefulCouponControllerMediatorWidget> createState() => _StatefulCouponControllerMediatorWidgetState();
}

class _StatefulCouponControllerMediatorWidgetState extends State<_StatefulCouponControllerMediatorWidget> {
  late final ModifiedPagingController<int, ListItemControllerState> _couponListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _couponListItemPagingControllerState;
  Coupon? _selectCoupon;

  @override
  void initState() {
    super.initState();
    _couponListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.couponController.apiRequestManager,
    );
    _couponListItemPagingControllerState = PagingControllerState(
      pagingController: _couponListItemPagingController,
      isPagingControllerExist: false
    );
    _couponListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _couponListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _couponListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _couponListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    LoadDataResult<List<Coupon>> couponListLoadDataResult = await widget.couponController.getCouponList(CouponListParameter());
    return couponListLoadDataResult.map<PagingResult<ListItemControllerState>>((couponList) {
      return PagingDataResult<ListItemControllerState>(
        itemList: [
          CouponContainerListItemControllerState(
            coupon: couponList,
            onUpdateState: () => setState(() {}),
            onGetLastSelectedCouponId: () => widget.couponId,
            onSelectCoupon: (coupon) {
              setState(() {
                _selectCoupon = coupon;
              });
            },
            onGetSelectedCoupon: () => _selectCoupon,
            couponContainerStorageListItemControllerState: DefaultCouponContainerStorageListItemControllerState()
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
            Text("My Coupon".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _couponListItemPagingControllerState,
                onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
                  pagingControllerState: pagingControllerState!
                ),
                pullToRefresh: true
              ),
            ),
            if (_selectCoupon != null)
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedOutlineGradientButton(
                      onPressed: () => Get.back(result: _selectCoupon!.id),
                      text: "Choose Address".tr,
                      outlineGradientButtonType: OutlineGradientButtonType.solid,
                      outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                    )
                  ]
                ),
              )
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