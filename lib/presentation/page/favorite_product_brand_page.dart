import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/misc/ext/paging_ext.dart';

import '../../controller/favorite_product_brand_controller.dart';
import '../../controller/product_brand_controller.dart';
import '../../domain/entity/product/productbrand/favorite_product_brand_paging_parameter.dart';
import '../../domain/entity/product/productbrand/product_brand.dart';
import '../../domain/entity/product/productbrand/product_brand_paging_parameter.dart';
import '../../domain/usecase/get_favorite_product_brand_use_case.dart';
import '../../domain/usecase/get_product_brand_paging_use_case.dart';
import '../../misc/additionalloadingindicatorchecker/product_bundle_additional_paging_result_parameter_checker.dart';
import '../../misc/constant.dart';
import '../../misc/controllercontentdelegate/product_brand_favorite_controller_content_delegate.dart';
import '../../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../../misc/controllerstate/listitemcontrollerstate/compound_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/load_data_result_dynamic_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/padding_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/favorite_product_brand_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/productbrandlistitemcontrollerstate/vertical_product_brand_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/title_and_description_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/virtual_spacing_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/itemtypelistsubinterceptor/verticalgriditemtypelistsubinterceptor/vertical_grid_item_type_list_sub_interceptor.dart';
import '../../misc/list_item_controller_state_helper.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/page_restoration_helper.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modifiedappbar/default_search_app_bar.dart';
import 'getx_page.dart';
import 'product_entry_page.dart';
import 'search_page.dart';

class FavoriteProductBrandPage extends RestorableGetxPage<_FavoriteProductBrandPageRestoration> {
  late final ControllerMember<FavoriteProductBrandController> _favoriteProductBrandController = ControllerMember<FavoriteProductBrandController>().addToControllerManager(controllerManager);

  FavoriteProductBrandPage({Key? key}) : super(key: key, pageRestorationId: () => "favorite-product-brand-page");

  @override
  void onSetController() {
    _favoriteProductBrandController.controller = GetExtended.put<FavoriteProductBrandController>(
      FavoriteProductBrandController(
        controllerManager,
        Injector.locator<GetFavoriteProductBrandPagingUseCase>(),
        Injector.locator<ProductBrandFavoriteControllerContentDelegate>()
      ),
      tag: pageName
    );
  }

  @override
  _FavoriteProductBrandPageRestoration createPageRestoration() => _FavoriteProductBrandPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulFavoriteProductBrandControllerMediatorWidget(
      favoriteProductBrandController: _favoriteProductBrandController.controller
    );
  }
}

class _FavoriteProductBrandPageRestoration extends MixableGetxPageRestoration with ProductEntryPageRestorationMixin, SearchPageRestorationMixin {
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

class FavoriteProductBrandPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  FavoriteProductBrandPageGetPageBuilderAssistant();

  @override
  GetPageBuilder get pageBuilder => (() => FavoriteProductBrandPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(FavoriteProductBrandPage()));
}

mixin FavoriteProductBrandPageRestorationMixin on MixableGetxPageRestoration {
  late FavoriteProductBrandPageRestorableRouteFuture favoriteProductBrandPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    favoriteProductBrandPageRestorableRouteFuture = FavoriteProductBrandPageRestorableRouteFuture(restorationId: restorationIdWithPageName('product-brand-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    favoriteProductBrandPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    favoriteProductBrandPageRestorableRouteFuture.dispose();
  }
}

class FavoriteProductBrandPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  FavoriteProductBrandPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        FavoriteProductBrandPageGetPageBuilderAssistant()
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

class _StatefulFavoriteProductBrandControllerMediatorWidget extends StatefulWidget {
  final FavoriteProductBrandController favoriteProductBrandController;

  const _StatefulFavoriteProductBrandControllerMediatorWidget({
    required this.favoriteProductBrandController,
  });

  @override
  State<_StatefulFavoriteProductBrandControllerMediatorWidget> createState() => _StatefulFavoriteProductBrandControllerMediatorWidgetState();
}

class _StatefulFavoriteProductBrandControllerMediatorWidgetState extends State<_StatefulFavoriteProductBrandControllerMediatorWidget> {
  late final ModifiedPagingController<int, ListItemControllerState> _favoriteProductBrandListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _favoriteProductBrandListItemPagingControllerState;
  final List<BaseLoadDataResultDynamicListItemControllerState> _dynamicItemLoadDataResultDynamicListItemControllerStateList = [];

  @override
  void initState() {
    super.initState();
    _favoriteProductBrandListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.favoriteProductBrandController.apiRequestManager,
      additionalPagingResultParameterChecker: Injector.locator<ProductBundleAdditionalPagingResultParameterChecker>()
    );
    _favoriteProductBrandListItemPagingControllerState = PagingControllerState(
      pagingController: _favoriteProductBrandListItemPagingController,
      isPagingControllerExist: false
    );
    _favoriteProductBrandListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _favoriteProductBrandListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _favoriteProductBrandListItemPagingControllerState.isPagingControllerExist = true;
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _favoriteProductBrandListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    LoadDataResult<PagingDataResult<ProductBrand>> favoriteProductBrandLoadDataResult = await widget.favoriteProductBrandController.getFavoriteProductBrandPaging(
      FavoriteProductBrandPagingParameter(
        page: pageKey,
        itemEachPageCount: 10
      )
    );
    return favoriteProductBrandLoadDataResult.map<PagingResult<ListItemControllerState>>((productBrandPaging) {
      List<ListItemControllerState> resultListItemControllerState = [];
      int totalItem = productBrandPaging.totalItem;
      if (pageKey == 1) {
        totalItem = 2;
        resultListItemControllerState = [
          FavoriteProductBrandContainerListItemControllerState(
            productBrandList: productBrandPaging.itemList,
            onTapProductBrand: (productBrand) => PageRestorationHelper.toProductEntryPage(
              context,
              ProductEntryPageParameter(
                productEntryParameterMap: {
                  "brand_id": productBrand.id,
                  "brand": productBrand.slug
                }
              )
            ),
            onRemoveFromFavoriteProductBrand: (productBrand) {

            }
          )
        ];
      } else {
        if (ListItemControllerStateHelper.checkListItemControllerStateList(listItemControllerStateList)) {
          FavoriteProductBrandContainerListItemControllerState favoriteProductBrandContainerListItemControllerState = ListItemControllerStateHelper.parsePageKeyedListItemControllerState(
            listItemControllerStateList![0]
          ) as FavoriteProductBrandContainerListItemControllerState;
          favoriteProductBrandContainerListItemControllerState.productBrandList.addAll(productBrandPaging.itemList);
        }
      }
      return PagingDataResult<ListItemControllerState>(
        itemList: resultListItemControllerState,
        page: productBrandPaging.page,
        totalPage: productBrandPaging.totalPage,
        totalItem: totalItem
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
                pagingControllerState: _favoriteProductBrandListItemPagingControllerState,
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