import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../controller/product_category_detail_controller.dart';
import '../../domain/entity/product/productcategory/product_category_detail.dart';
import '../../domain/entity/product/productcategory/product_category_detail_parameter.dart';
import '../../domain/usecase/get_product_category_detail_use_case.dart';
import '../../misc/additionalloadingindicatorchecker/product_category_detail_additional_paging_result_parameter_checker.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/product_category_header_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/productlistitemcontrollerstate/vertical_product_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/error/message_error.dart';
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
import '../widget/modifiedappbar/default_search_app_bar.dart';
import 'getx_page.dart';
import 'product_detail_page.dart';
import 'search_page.dart';

class ProductCategoryDetailPage extends RestorableGetxPage<_ProductCategoryDetailPageRestoration> {
  late final ControllerMember<ProductCategoryDetailController> _productCategoryDetailController = ControllerMember<ProductCategoryDetailController>().addToControllerManager(controllerManager);

  final String productCategoryId;

  ProductCategoryDetailPage({Key? key, required this.productCategoryId}) : super(key: key, pageRestorationId: () => "product-category-detail-page");

  @override
  void onSetController() {
    _productCategoryDetailController.controller = GetExtended.put<ProductCategoryDetailController>(
      ProductCategoryDetailController(controllerManager, Injector.locator<GetProductCategoryDetailUseCase>()), tag: pageName
    );
  }

  @override
  _ProductCategoryDetailPageRestoration createPageRestoration() => _ProductCategoryDetailPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulProductCategoryDetailControllerMediatorWidget(
        productCategoryId: productCategoryId,
        productCategoryDetailController: _productCategoryDetailController.controller,
      ),
    );
  }
}

class _ProductCategoryDetailPageRestoration extends MixableGetxPageRestoration with ProductDetailPageRestorationMixin, SearchPageRestorationMixin {
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

class ProductCategoryDetailPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  final String productCategoryId;

  ProductCategoryDetailPageGetPageBuilderAssistant({
    required this.productCategoryId
  });

  @override
  GetPageBuilder get pageBuilder => (() => ProductCategoryDetailPage(productCategoryId: productCategoryId));

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(ProductCategoryDetailPage(productCategoryId: productCategoryId)));
}

mixin ProductCategoryDetailPageRestorationMixin on MixableGetxPageRestoration {
  late ProductCategoryDetailPageRestorableRouteFuture productCategoryDetailPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    productCategoryDetailPageRestorableRouteFuture = ProductCategoryDetailPageRestorableRouteFuture(restorationId: restorationIdWithPageName('product-category-detail-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    productCategoryDetailPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    productCategoryDetailPageRestorableRouteFuture.dispose();
  }
}

class ProductCategoryDetailPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  ProductCategoryDetailPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    if (arguments is! String) {
      throw MessageError(message: "Arguments must be a String");
    }
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(ProductCategoryDetailPageGetPageBuilderAssistant(productCategoryId: arguments)),
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

class _StatefulProductCategoryDetailControllerMediatorWidget extends StatefulWidget {
  final ProductCategoryDetailController productCategoryDetailController;
  final String productCategoryId;

  const _StatefulProductCategoryDetailControllerMediatorWidget({
    required this.productCategoryDetailController,
    required this.productCategoryId
  });

  @override
  State<_StatefulProductCategoryDetailControllerMediatorWidget> createState() => _StatefulProductCategoryDetailControllerMediatorWidgetState();
}

class _StatefulProductCategoryDetailControllerMediatorWidgetState extends State<_StatefulProductCategoryDetailControllerMediatorWidget> {
  late final ModifiedPagingController<int, ListItemControllerState> _productCategoryDetailListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _productCategoryDetailListItemPagingControllerState;

  @override
  void initState() {
    super.initState();
    _productCategoryDetailListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.productCategoryDetailController.apiRequestManager,
      additionalPagingResultParameterChecker: Injector.locator<ProductCategoryDetailAdditionalPagingResultParameterChecker>()
    );
    _productCategoryDetailListItemPagingControllerState = PagingControllerState(
      pagingController: _productCategoryDetailListItemPagingController,
      isPagingControllerExist: false
    );
    _productCategoryDetailListItemPagingControllerState.pagingController.addPageRequestListenerForLoadDataResult(
      listener: _productCategoryDetailListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _productCategoryDetailListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _productCategoryDetailListItemPagingControllerStateListener(int pageKey) async {
    LoadDataResult<ProductCategoryDetail> productCategoryDetailLoadDataResult = await widget.productCategoryDetailController.getProductCategoryDetail(
      ProductCategoryDetailParameter(
        productCategoryDetailId: widget.productCategoryId,
        productCategoryDetailParameterType: ProductCategoryDetailParameterType.id
      )
    );
    return productCategoryDetailLoadDataResult.map((productCategoryDetail) {
      return PagingDataResult<ListItemControllerState>(
        page: 1,
        totalPage: 1,
        totalItem: 1,
        itemList: [
          ProductCategoryHeaderListItemControllerState(productCategory: productCategoryDetail),
          ...productCategoryDetail.shortProductList.map<ListItemControllerState>((product) {
            return VerticalProductListItemControllerState(
              productAppearanceData: product,
              onRemoveWishlist: (productOrProductEntryId) {},
              onAddWishlist: (productOrProductEntryId) {}
            );
          }).toList()
        ]
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultSearchAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _productCategoryDetailListItemPagingControllerState,
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