import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/misc/ext/paging_ext.dart';

import '../../controller/product_bundle_controller.dart';
import '../../domain/entity/cart/support_cart.dart';
import '../../domain/entity/product/productbundle/product_bundle.dart';
import '../../domain/entity/product/productbundle/product_bundle_paging_parameter.dart';
import '../../domain/entity/wishlist/support_wishlist.dart';
import '../../domain/usecase/get_product_bundle_paging_use_case.dart';
import '../../misc/additionalloadingindicatorchecker/product_bundle_additional_paging_result_parameter_checker.dart';
import '../../misc/constant.dart';
import '../../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../../misc/controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/productbundlelistitemcontrollerstate/vertical_product_bundle_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/error/message_error.dart';
import '../../misc/errorprovider/error_provider.dart';
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
import 'product_bundle_detail_page.dart';
import 'search_page.dart';

class ProductBundlePage extends RestorableGetxPage<_ProductBundlePageRestoration> {
  late final ControllerMember<ProductBundleController> _productBundleController = ControllerMember<ProductBundleController>().addToControllerManager(controllerManager);

  ProductBundlePage({Key? key}) : super(key: key, pageRestorationId: () => "product-bundle-page");

  @override
  void onSetController() {
    _productBundleController.controller = GetExtended.put<ProductBundleController>(
      ProductBundleController(
        controllerManager,
        Injector.locator<GetProductBundlePagingUseCase>(),
        Injector.locator<WishlistAndCartControllerContentDelegate>()
      ),
      tag: pageName
    );
  }

  @override
  _ProductBundlePageRestoration createPageRestoration() => _ProductBundlePageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulProductBundleControllerMediatorWidget(
        productBundleController: _productBundleController.controller,
      ),
    );
  }
}

class _ProductBundlePageRestoration extends MixableGetxPageRestoration with ProductBundleDetailPageRestorationMixin, SearchPageRestorationMixin {
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

class ProductBundlePageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => ProductBundlePage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(ProductBundlePage()));
}

mixin ProductBundlePageRestorationMixin on MixableGetxPageRestoration {
  late ProductBundlePageRestorableRouteFuture productBundlePageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    productBundlePageRestorableRouteFuture = ProductBundlePageRestorableRouteFuture(restorationId: restorationIdWithPageName('product-bundle-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    productBundlePageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    productBundlePageRestorableRouteFuture.dispose();
  }
}

class ProductBundlePageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  ProductBundlePageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(ProductBundlePageGetPageBuilderAssistant()),
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

class _StatefulProductBundleControllerMediatorWidget extends StatefulWidget {
  final ProductBundleController productBundleController;

  const _StatefulProductBundleControllerMediatorWidget({
    required this.productBundleController
  });

  @override
  State<_StatefulProductBundleControllerMediatorWidget> createState() => _StatefulProductBundleControllerMediatorWidgetState();
}

class _StatefulProductBundleControllerMediatorWidgetState extends State<_StatefulProductBundleControllerMediatorWidget> {
  late final ModifiedPagingController<int, ListItemControllerState> _productBundleListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _productBundleListItemPagingControllerState;

  @override
  void initState() {
    super.initState();
    _productBundleListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.productBundleController.apiRequestManager,
      additionalPagingResultParameterChecker: Injector.locator<ProductBundleAdditionalPagingResultParameterChecker>()
    );
    _productBundleListItemPagingControllerState = PagingControllerState(
      pagingController: _productBundleListItemPagingController,
      isPagingControllerExist: false
    );
    _productBundleListItemPagingControllerState.pagingController.addPageRequestListenerForLoadDataResult(
      listener: _productCategoryDetailListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _productBundleListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _productCategoryDetailListItemPagingControllerStateListener(int pageKey) async {
    LoadDataResult<PagingDataResult<ProductBundle>> productBundlePagingLoadDataResult = await widget.productBundleController.getProductBundlePaging(
      ProductBundlePagingParameter(page: pageKey)
    );
    return productBundlePagingLoadDataResult.map((productBundlePaging) {
      return productBundlePaging.map(
        (productBundle) => VerticalProductBundleListItemControllerState(
          productBundle: productBundle,
          onAddWishlist: (productBundleOutput) => widget.productBundleController.wishlistAndCartControllerContentDelegate.addToWishlist(productBundleOutput),
          onRemoveWishlist: (productBundleOutput) => widget.productBundleController.wishlistAndCartControllerContentDelegate.removeFromWishlist(productBundleOutput),
          onAddCart: (productBundleOutput) => widget.productBundleController.wishlistAndCartControllerContentDelegate.addToCart(productBundleOutput),
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.productBundleController.wishlistAndCartControllerContentDelegate.setWishlistAndCartDelegate(
      Injector.locator<WishlistAndCartDelegateFactory>().generateWishlistAndCartDelegate(
        onGetBuildContext: () => context,
        onGetErrorProvider: () => Injector.locator<ErrorProvider>()
      )
    );
    return Scaffold(
      appBar: DefaultSearchAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _productBundleListItemPagingControllerState,
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