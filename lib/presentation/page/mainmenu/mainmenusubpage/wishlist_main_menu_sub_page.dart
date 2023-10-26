import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/error_provider_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../../../controller/mainmenucontroller/mainmenusubpagecontroller/wishlist_main_menu_sub_controller.dart';
import '../../../../domain/entity/cart/support_cart.dart';
import '../../../../domain/entity/wishlist/wishlist.dart';
import '../../../../domain/entity/wishlist/wishlist_paging_parameter.dart';
import '../../../../misc/additionalloadingindicatorchecker/wishlist_sub_additional_paging_result_parameter_checker.dart';
import '../../../../misc/constant.dart';
import '../../../../misc/controllercontentdelegate/wishlist_and_cart_controller_content_delegate.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/wishlistlistitemcontrollerstate/wishlist_container_list_item_controller_state.dart';
import '../../../../misc/controllerstate/paging_controller_state.dart';
import '../../../../misc/errorprovider/error_provider.dart';
import '../../../../misc/injector.dart';
import '../../../../misc/itemtypelistsubinterceptor/wishlist_item_type_list_sub_interceptor.dart';
import '../../../../misc/list_item_controller_state_helper.dart';
import '../../../../misc/load_data_result.dart';
import '../../../../misc/main_route_observer.dart';
import '../../../../misc/manager/controller_manager.dart';
import '../../../../misc/paging/modified_paging_controller.dart';
import '../../../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../../../misc/paging/pagingresult/paging_data_result.dart';
import '../../../../misc/paging/pagingresult/paging_result.dart';
import '../../../../misc/toast_helper.dart';
import '../../../../misc/widget_helper.dart';
import '../../../widget/background_app_bar_scaffold.dart';
import '../../../widget/modified_paged_list_view.dart';
import '../../../widget/modifiedappbar/main_menu_search_app_bar.dart';
import '../../getx_page.dart';

class WishlistMainMenuSubPage extends DefaultGetxPage {
  late final ControllerMember<WishlistMainMenuSubController> _wishlistMainMenuSubController = ControllerMember<WishlistMainMenuSubController>().addToControllerManager(controllerManager);
  final String ancestorPageName;

  WishlistMainMenuSubPage({Key? key, required this.ancestorPageName}) : super(key: key);

  @override
  void onSetController() {
    _wishlistMainMenuSubController.controller = Injector.locator<WishlistMainMenuSubControllerInjectionFactory>().inject(controllerManager, ancestorPageName);
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulWishlistMainMenuSubControllerMediatorWidget(
      wishlistMainMenuSubController: _wishlistMainMenuSubController.controller
    );
  }
}

class _StatefulWishlistMainMenuSubControllerMediatorWidget extends StatefulWidget {
  final WishlistMainMenuSubController wishlistMainMenuSubController;

  const _StatefulWishlistMainMenuSubControllerMediatorWidget({
    required this.wishlistMainMenuSubController
  });

  @override
  State<_StatefulWishlistMainMenuSubControllerMediatorWidget> createState() => _StatefulWishlistMainMenuSubControllerMediatorWidgetState();
}

class _StatefulWishlistMainMenuSubControllerMediatorWidgetState extends State<_StatefulWishlistMainMenuSubControllerMediatorWidget> {
  late AssetImage _wishlistAppBarBackgroundAssetImage;
  late final ModifiedPagingController<int, ListItemControllerState> _wishlistMainMenuSubListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _wishlistMainMenuSubListItemPagingControllerState;
  DefaultWishlistContainerInterceptingActionListItemControllerState defaultWishlistContainerInterceptingActionListItemControllerState = DefaultWishlistContainerInterceptingActionListItemControllerState();

  @override
  void initState() {
    super.initState();
    _wishlistAppBarBackgroundAssetImage = AssetImage(Constant.imagePatternWishlistMainMenuAppBar);
    _wishlistMainMenuSubListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.wishlistMainMenuSubController.apiRequestManager,
      additionalPagingResultParameterChecker: Injector.locator<WishlistSubAdditionalPagingResultParameterChecker>()
    );
    _wishlistMainMenuSubListItemPagingControllerState = PagingControllerState(
      pagingController: _wishlistMainMenuSubListItemPagingController,
      isPagingControllerExist: false
    );
    _wishlistMainMenuSubListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _wishlistMainMenuListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _wishlistMainMenuSubListItemPagingControllerState.isPagingControllerExist = true;
    MainRouteObserver.controllerMediatorMap[Constant.subPageKeyWishlistMainMenu] = refreshWishlistMainMenu;
    MainRouteObserver.onRefreshWishlistInMainMenu = refreshWishlistMainMenu;
  }

  @override
  void didChangeDependencies() {
    precacheImage(_wishlistAppBarBackgroundAssetImage, context);
    super.didChangeDependencies();
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _wishlistMainMenuListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? listItemControllerStateList) async {
    LoadDataResult<PagingDataResult<Wishlist>> wishlistPagingLoadDataResult = await widget.wishlistMainMenuSubController.getWishlistPaging(
      WishlistPagingParameter(page: pageKey)
    );
    return wishlistPagingLoadDataResult.map<PagingResult<ListItemControllerState>>((wishlistPaging) {
      List<ListItemControllerState> resultListItemControllerState = [];
      int totalItem = wishlistPaging.totalItem;
      if (pageKey == 1) {
        totalItem = 2;
        resultListItemControllerState = [
          WishlistContainerListItemControllerState(
            wishlistList: wishlistPaging.itemList,
            onUpdateState: () => setState(() {}),
            onRemoveWishlistWithWishlist: (wishlist) => widget.wishlistMainMenuSubController.wishlistAndCartControllerContentDelegate.removeFromWishlistDirectly(wishlist),
            onAddProductCart: (productAppearanceData) => widget.wishlistMainMenuSubController.wishlistAndCartControllerContentDelegate.addToCart(productAppearanceData as SupportCart),
            onAddProductBundleCart: (productBundle) => widget.wishlistMainMenuSubController.wishlistAndCartControllerContentDelegate.addToCart(productBundle),
            wishlistContainerInterceptingActionListItemControllerState: defaultWishlistContainerInterceptingActionListItemControllerState
          )
        ];
      } else {
        if (ListItemControllerStateHelper.checkListItemControllerStateList(listItemControllerStateList)) {
          WishlistContainerListItemControllerState wishlistContainerListItemControllerState = ListItemControllerStateHelper.parsePageKeyedListItemControllerState(
            listItemControllerStateList![0]
          ) as WishlistContainerListItemControllerState;
          wishlistContainerListItemControllerState.wishlistList.addAll(wishlistPaging.itemList);
        }
      }
      return PagingDataResult<ListItemControllerState>(
        itemList: resultListItemControllerState,
        page: wishlistPaging.page,
        totalPage: wishlistPaging.totalPage,
        totalItem: totalItem
      );
    });
  }

  void refreshWishlistMainMenu() {
    _wishlistMainMenuSubListItemPagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    widget.wishlistMainMenuSubController.wishlistAndCartControllerContentDelegate.setWishlistAndCartDelegate(
      Injector.locator<WishlistAndCartDelegateFactory>().generateWishlistAndCartDelegate(
        onGetBuildContext: () => context,
        onGetErrorProvider: () => Injector.locator<ErrorProvider>(),
        onRemoveFromWishlistRequestProcessSuccessCallback: (wishlist) async {
          if (defaultWishlistContainerInterceptingActionListItemControllerState.removeWishlist != null) {
            defaultWishlistContainerInterceptingActionListItemControllerState.removeWishlist!(wishlist);
          }
        },
        onRemoveFromWishlistRequestProcessFailedCallback: (e) async {
          ErrorProvider errorProvider = Injector.locator<ErrorProvider>();
          ErrorProviderResult errorProviderResult = errorProvider.onGetErrorProviderResult(e).toErrorProviderResultNonNull();
          ToastHelper.showToast(errorProviderResult.message);
        }
      )
    );
    return BackgroundAppBarScaffold(
      backgroundAppBarImage: _wishlistAppBarBackgroundAssetImage,
      appBar: MainMenuSearchAppBar(value: 0.0),
      body: Expanded(
        child: WidgetHelper.checkingLogin(
          context,
          () => ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
            pagingControllerState: _wishlistMainMenuSubListItemPagingControllerState,
            onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
              pagingControllerState: pagingControllerState!
            ),
            pullToRefresh: true
          ),
          Injector.locator<ErrorProvider>()
        )
      ),
    );
  }
}