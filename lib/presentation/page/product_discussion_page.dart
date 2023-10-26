import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../controller/product_discussion_controller.dart';
import '../../domain/entity/product/productdiscussion/product_discussion.dart';
import '../../domain/entity/product/productdiscussion/product_discussion_paging_parameter.dart';
import '../../domain/usecase/get_product_discussion_dialog_paging_use_case.dart';
import '../../domain/usecase/get_product_discussion_paging_use_case.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/product_discussion_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/productdiscussionlistitemcontrollerstate/product_discussion_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/itemtypelistsubinterceptor/product_discussion_container_item_type_list_sub_interceptor.dart';
import '../../misc/list_item_controller_state_helper.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import 'getx_page.dart';

class ProductDiscussionPage extends RestorableGetxPage<_ProductDiscussionPageRestoration> {
  late final ControllerMember<ProductDiscussionController> _productDiscussionController = ControllerMember<ProductDiscussionController>().addToControllerManager(controllerManager);

  ProductDiscussionPage({
    Key? key
  }) : super(
    key: key,
    pageRestorationId: () => "product-discussion-page"
  );

  @override
  void onSetController() {
    _productDiscussionController.controller = GetExtended.put<ProductDiscussionController>(
      ProductDiscussionController(
        controllerManager,
        Injector.locator<GetProductDiscussionPagingUseCase>(),
        Injector.locator<GetProductDiscussionDialogPagingUseCase>()
      ),
      tag: pageName
    );
  }

  @override
  _ProductDiscussionPageRestoration createPageRestoration() => _ProductDiscussionPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulProductDiscussionControllerMediatorWidget(
      productDiscussionController: _productDiscussionController.controller,
    );
  }
}

class _ProductDiscussionPageRestoration extends MixableGetxPageRestoration {
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

class ProductDiscussionPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  ProductDiscussionPageGetPageBuilderAssistant();

  @override
  GetPageBuilder get pageBuilder => (() => ProductDiscussionPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(ProductDiscussionPage()));
}

mixin ProductDiscussionPageRestorationMixin on MixableGetxPageRestoration {
  late ProductDiscussionPageRestorableRouteFuture productDiscussionPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    productDiscussionPageRestorableRouteFuture = ProductDiscussionPageRestorableRouteFuture(restorationId: restorationIdWithPageName('product-discussion-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    productDiscussionPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    productDiscussionPageRestorableRouteFuture.dispose();
  }
}

class ProductDiscussionPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  ProductDiscussionPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        ProductDiscussionPageGetPageBuilderAssistant()
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

class _StatefulProductDiscussionControllerMediatorWidget extends StatefulWidget {
  final ProductDiscussionController productDiscussionController;

  const _StatefulProductDiscussionControllerMediatorWidget({
    required this.productDiscussionController
  });

  @override
  State<_StatefulProductDiscussionControllerMediatorWidget> createState() => _StatefulProductDiscussionControllerMediatorWidgetState();
}

class _StatefulProductDiscussionControllerMediatorWidgetState extends State<_StatefulProductDiscussionControllerMediatorWidget> {
  late final ScrollController _productDiscussionScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _productDiscussionListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _productDiscussionListItemPagingControllerState;

  @override
  void initState() {
    super.initState();
    _productDiscussionScrollController = ScrollController();
    _productDiscussionListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.productDiscussionController.apiRequestManager
    );
    _productDiscussionListItemPagingControllerState = PagingControllerState(
      scrollController: _productDiscussionScrollController,
      pagingController: _productDiscussionListItemPagingController,
      isPagingControllerExist: false
    );
    _productDiscussionListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _productDiscussionListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _productDiscussionListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _productDiscussionListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? orderListItemControllerStateList) async {
    LoadDataResult<PagingDataResult<ProductDiscussion>> productDiscussionPagingLoadDataResult = await widget.productDiscussionController.getProductDiscussionPaging(
      ProductDiscussionPagingParameter(page: pageKey)
    );
    return productDiscussionPagingLoadDataResult.map<PagingResult<ListItemControllerState>>((productDiscussionPaging) {
      List<ListItemControllerState> resultListItemControllerState = [];
      List<ProductDiscussionListItemValue> productDiscussionListItemValueList = productDiscussionPaging.itemList.map<ProductDiscussionListItemValue>(
        (productDiscussion) => ProductDiscussionListItemValue(
          productDiscussion: productDiscussion,
          isExpanded: false,
        )
      ).toList();
      int totalItem = productDiscussionPaging.totalItem;
      if (pageKey == 1) {
        totalItem = 1;
        resultListItemControllerState = [
          ProductDiscussionContainerListItemControllerState(
            productDiscussionListItemValueList: productDiscussionListItemValueList,
            onUpdateState: () => setState(() {}),
            productDiscussionListItemValueStorage: DefaultProductDiscussionListItemValueStorage(),
            productDiscussionContainerActionListItemControllerState: DefaultProductDiscussionContainerActionListItemControllerState(
              getProductDiscussionDialogPaging: widget.productDiscussionController.getProductDiscussionDialogPaging
            )
          )
        ];
      } else {
        if (ListItemControllerStateHelper.checkListItemControllerStateList(orderListItemControllerStateList)) {
          ProductDiscussionContainerListItemControllerState productDiscussionContainerListItemControllerState = ListItemControllerStateHelper.parsePageKeyedListItemControllerState(orderListItemControllerStateList![0]) as ProductDiscussionContainerListItemControllerState;
          productDiscussionContainerListItemControllerState.productDiscussionListItemValueList.addAll(productDiscussionListItemValueList);
        }
      }
      return PagingDataResult<ListItemControllerState>(
        itemList: resultListItemControllerState,
        page: productDiscussionPaging.page,
        totalPage: productDiscussionPaging.totalPage,
        totalItem: totalItem
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("Product Discussion".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _productDiscussionListItemPagingControllerState,
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
}