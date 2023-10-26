import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../controller/country_delivery_review_controller.dart';
import '../../controller/search_controller.dart';
import '../../domain/entity/cart/support_cart.dart';
import '../../domain/entity/product/product_with_condition_paging_parameter.dart';
import '../../domain/entity/product/productentry/product_entry.dart';
import '../../domain/entity/wishlist/support_wishlist.dart';
import '../../domain/usecase/get_product_entry_with_condition_paging_use_case.dart';
import '../../misc/constant.dart';
import '../../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/load_data_result_dynamic_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/searchlistitemcontrollerstate/search_container_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/entityandlistitemcontrollerstatemediator/horizontal_component_entity_parameterized_entity_and_list_item_controller_state_mediator.dart';
import '../../misc/error/search_not_found_error.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/list_item_controller_state_helper.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../../misc/parameterizedcomponententityandlistitemcontrollerstatemediatorparameter/horizontal_dynamic_item_carousel_parametered_component_entity_and_list_item_controller_state_mediator_parameter.dart';
import '../widget/background_app_bar_scaffold.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modifiedappbar/core_search_app_bar.dart';
import 'getx_page.dart';
import 'product_detail_page.dart';

class SearchPage extends RestorableGetxPage<_SearchPageRestoration> {
  late final ControllerMember<SearchController> _searchController = ControllerMember<SearchController>().addToControllerManager(controllerManager);

  SearchPage({
    Key? key,
  }) : super(
    key: key,
    pageRestorationId: () => "search-page",
  );

  @override
  void onSetController() {
    _searchController.controller = GetExtended.put<SearchController>(
      SearchController(
        controllerManager,
        Injector.locator<GetProductEntryWithConditionPagingUseCase>(),
        Injector.locator<WishlistAndCartControllerContentDelegate>()
      ),
      tag: pageName
    );
  }

  @override
  _SearchPageRestoration createPageRestoration() => _SearchPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulSearchControllerMediatorWidget(
      searchController: _searchController.controller,
    );
  }
}

class _SearchPageRestoration extends MixableGetxPageRestoration with ProductDetailPageRestorationMixin {
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

class SearchPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => SearchPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(SearchPage()));
}

mixin SearchPageRestorationMixin on MixableGetxPageRestoration {
  late SearchPageRestorableRouteFuture searchPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    searchPageRestorableRouteFuture = SearchPageRestorableRouteFuture(
      restorationId: restorationIdWithPageName('country-delivery-review-route')
    );
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    searchPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    searchPageRestorableRouteFuture.dispose();
  }
}

class SearchPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  SearchPageRestorableRouteFuture({
    required String restorationId
  }) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      }
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<String?>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(
        SearchPageGetPageBuilderAssistant()
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

class _StatefulSearchControllerMediatorWidget extends StatefulWidget {
  final SearchController searchController;

  const _StatefulSearchControllerMediatorWidget({
    required this.searchController,
  });

  @override
  State<_StatefulSearchControllerMediatorWidget> createState() => _StatefulSearchControllerMediatorWidgetState();
}

class _StatefulSearchControllerMediatorWidgetState extends State<_StatefulSearchControllerMediatorWidget> {
  late AssetImage _searchAppBarBackgroundAssetImage;
  late final ModifiedPagingController<int, ListItemControllerState> _searchListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _searchListItemPagingControllerState;
  final TextEditingController _searchTextEditingController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  int _searchStatus = 0;
  int _searchCount = 0;

  @override
  void initState() {
    super.initState();
    _searchAppBarBackgroundAssetImage = AssetImage(Constant.imagePatternExploreNusantaraMainMenuAppBar);
    _searchListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.searchController.apiRequestManager,
    );
    _searchListItemPagingControllerState = PagingControllerState(
      pagingController: _searchListItemPagingController,
      isPagingControllerExist: false
    );
    _searchListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _searchListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _searchListItemPagingControllerState.isPagingControllerExist = true;
  }

  @override
  void didChangeDependencies() {
    precacheImage(_searchAppBarBackgroundAssetImage, context);
    super.didChangeDependencies();
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _searchListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    LoadDataResult<PagingDataResult<ProductEntry>> productEntryLoadDataResult = await widget.searchController.getProductEntrySearch(
      ProductWithConditionPagingParameter(
        page: pageKey,
        withCondition: {"product": _searchTextEditingController.text},
        onInterceptProductPagingDataResult: (productEntryPagingDataResult) {
          if (productEntryPagingDataResult.itemList.isEmpty) {
            throw SearchNotFoundError();
          }
          return productEntryPagingDataResult;
        }
      )
    );
    return productEntryLoadDataResult.map<PagingResult<ListItemControllerState>>((productEntryPaging) {
      List<ListItemControllerState> resultListItemControllerState = [];
      int totalItem = productEntryPaging.totalItem;
      if (pageKey == 1) {
        totalItem = 1;
        resultListItemControllerState = [
          SearchContainerListItemControllerState(
            productEntryList: productEntryPaging.itemList,
            onUpdateState: () => setState(() {}),
            onRemoveWishlistWithProductAppearanceData: (productAppearanceData) => widget.searchController.wishlistAndCartControllerContentDelegate.removeFromWishlist(productAppearanceData as SupportWishlist),
            onAddWishlistWithProductAppearanceData: (productAppearanceData) => widget.searchController.wishlistAndCartControllerContentDelegate.addToWishlist(productAppearanceData as SupportWishlist),
            onAddProductCart: (productAppearanceData) => widget.searchController.wishlistAndCartControllerContentDelegate.addToCart(productAppearanceData as SupportCart),
          )
        ];
      } else {
        if (ListItemControllerStateHelper.checkListItemControllerStateList(listItemControllerStateList)) {
          SearchContainerListItemControllerState searchContainerListItemControllerState = ListItemControllerStateHelper.parsePageKeyedListItemControllerState(listItemControllerStateList![0]) as SearchContainerListItemControllerState;
          searchContainerListItemControllerState.productEntryList.addAll(productEntryPaging.itemList);
        }
      }
      return PagingDataResult<ListItemControllerState>(
        itemList: resultListItemControllerState,
        page: productEntryPaging.page,
        totalPage: productEntryPaging.totalPage,
        totalItem: totalItem
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.searchController.wishlistAndCartControllerContentDelegate.setWishlistAndCartDelegate(
      Injector.locator<WishlistAndCartDelegateFactory>().generateWishlistAndCartDelegate(
        onGetBuildContext: () => context,
        onGetErrorProvider: () => Injector.locator<ErrorProvider>()
      )
    );
    return BackgroundAppBarScaffold(
      backgroundAppBarImage: _searchAppBarBackgroundAssetImage,
      appBar: CoreSearchAppBar(
        value: 0.0,
        showFilterIconButton: false,
        onSearch: (search) {
          FocusScope.of(context).unfocus();
          setState(() => _searchStatus = 1);
          if (_searchCount > 0) {
            _searchListItemPagingController.refresh();
          }
          _searchCount += 1;
        },
        readOnly: false,
        searchTextEditingController: _searchTextEditingController,
        onSearchTextFieldTapped: () {},
        searchFocusNode: _searchFocusNode,
      ),
      body: Expanded(
        child: _searchStatus == 0 ? Container() : ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
          pagingControllerState: _searchListItemPagingControllerState,
          onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
            pagingControllerState: pagingControllerState!
          ),
          pullToRefresh: true
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}