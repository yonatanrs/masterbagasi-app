import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';
import 'package:masterbagasi/misc/ext/paging_controller_ext.dart';

import '../../controller/cart_controller.dart';
import '../../domain/entity/additionalitem/add_additional_item_parameter.dart';
import '../../domain/entity/additionalitem/add_additional_item_response.dart';
import '../../domain/entity/additionalitem/additional_item.dart';
import '../../domain/entity/additionalitem/additional_item_list_parameter.dart';
import '../../domain/entity/additionalitem/change_additional_item_parameter.dart';
import '../../domain/entity/additionalitem/change_additional_item_response.dart';
import '../../domain/entity/additionalitem/remove_additional_item_parameter.dart';
import '../../domain/entity/additionalitem/remove_additional_item_response.dart';
import '../../domain/entity/cart/cart.dart';
import '../../domain/entity/cart/cart_paging_parameter.dart';
import '../../domain/entity/cart/support_cart.dart';
import '../../domain/entity/wishlist/support_wishlist.dart';
import '../../domain/usecase/add_additional_item_use_case.dart';
import '../../domain/usecase/add_to_cart_use_case.dart';
import '../../domain/usecase/add_wishlist_use_case.dart';
import '../../domain/usecase/change_additional_item_use_case.dart';
import '../../domain/usecase/get_additional_item_use_case.dart';
import '../../domain/usecase/get_cart_summary_use_case.dart';
import '../../domain/usecase/get_my_cart_use_case.dart';
import '../../domain/usecase/remove_additional_item_use_case.dart';
import '../../domain/usecase/remove_from_cart_use_case.dart';
import '../../misc/additionalloadingindicatorchecker/cart_additional_paging_result_parameter_checker.dart';
import '../../misc/constant.dart';
import '../../misc/controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/cart_container_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/cart_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/cartlistitemcontrollerstate/vertical_cart_list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../misc/controllerstate/listitemcontrollerstate/page_keyed_list_item_controller_state.dart';
import '../../misc/controllerstate/paging_controller_state.dart';
import '../../misc/dialog_helper.dart';
import '../../misc/error/cart_empty_error.dart';
import '../../misc/errorprovider/error_provider.dart';
import '../../misc/getextended/get_extended.dart';
import '../../misc/getextended/get_restorable_route_future.dart';
import '../../misc/injector.dart';
import '../../misc/itemtypelistsubinterceptor/cart_item_type_list_sub_interceptor.dart';
import '../../misc/list_item_controller_state_helper.dart';
import '../../misc/load_data_result.dart';
import '../../misc/manager/controller_manager.dart';
import '../../misc/page_restoration_helper.dart';
import '../../misc/paging/modified_paging_controller.dart';
import '../../misc/paging/pagingcontrollerstatepagedchildbuilderdelegate/list_item_paging_controller_state_paged_child_builder_delegate.dart';
import '../../misc/paging/pagingresult/paging_data_result.dart';
import '../../misc/paging/pagingresult/paging_result.dart';
import '../../misc/toast_helper.dart';
import '../widget/button/custombutton/sized_outline_gradient_button.dart';
import '../widget/modified_paged_list_view.dart';
import '../widget/modified_svg_picture.dart';
import '../widget/modifiedappbar/modified_app_bar.dart';
import '../widget/sharedcart/shared_cart_indicator.dart';
import '../widget/tap_area.dart';
import 'delivery_page.dart';
import 'getx_page.dart';
import 'modaldialogpage/add_cart_note_modal_dialog_page.dart';
import 'modaldialogpage/cart_summary_cart_modal_dialog_page.dart';
import 'take_friend_cart_page.dart';
import 'dart:math' as math;

class CartPage extends RestorableGetxPage<_CartPageRestoration> {
  late final ControllerMember<CartController> _cartController = ControllerMember<CartController>().addToControllerManager(controllerManager);

  CartPage({Key? key}) : super(key: key, pageRestorationId: () => "cart-page");

  @override
  void onSetController() {
    _cartController.controller = GetExtended.put<CartController>(
      CartController(
        controllerManager,
        Injector.locator<GetMyCartUseCase>(),
        Injector.locator<AddToCartUseCase>(),
        Injector.locator<RemoveFromCartUseCase>(),
        Injector.locator<GetCartSummaryUseCase>(),
        Injector.locator<GetAdditionalItemUseCase>(),
        Injector.locator<AddAdditionalItemUseCase>(),
        Injector.locator<ChangeAdditionalItemUseCase>(),
        Injector.locator<RemoveAdditionalItemUseCase>(),
        Injector.locator<AddWishlistUseCase>()
      ),
      tag: pageName
    );
  }

  @override
  _CartPageRestoration createPageRestoration() => _CartPageRestoration();

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: _StatefulCartControllerMediatorWidget(
        cartController: _cartController.controller,
      ),
    );
  }
}

class _CartPageRestoration extends MixableGetxPageRestoration with CartPageRestorationMixin, TakeFriendCartPageRestorationMixin, DeliveryPageRestorationMixin {
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

class CartPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => CartPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(CartPage()));
}

mixin CartPageRestorationMixin on MixableGetxPageRestoration {
  late CartPageRestorableRouteFuture cartPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    cartPageRestorableRouteFuture = CartPageRestorableRouteFuture(restorationId: restorationIdWithPageName('cart-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    cartPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    cartPageRestorableRouteFuture.dispose();
  }
}

class CartPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  CartPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
      },
    );
  }

  static Route<void>? _getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(CartPageGetPageBuilderAssistant()),
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

class _StatefulCartControllerMediatorWidget extends StatefulWidget {
  final CartController cartController;

  const _StatefulCartControllerMediatorWidget({
    required this.cartController
  });

  @override
  State<_StatefulCartControllerMediatorWidget> createState() => _StatefulCartControllerMediatorWidgetState();
}

class _StatefulCartControllerMediatorWidgetState extends State<_StatefulCartControllerMediatorWidget> {
  late final ScrollController _cartScrollController;
  late final ModifiedPagingController<int, ListItemControllerState> _cartListItemPagingController;
  late final PagingControllerState<int, ListItemControllerState> _cartListItemPagingControllerState;
  int _cartCount = 0;
  late int _selectedCartCount = 0;
  late double _selectedCartShoppingTotal = 0;
  List<AdditionalItem> _additionalItemList = [];
  List<Cart> _selectedCartList = [];
  final CartContainerInterceptingActionListItemControllerState _cartContainerInterceptingActionListItemControllerState = DefaultCartContainerInterceptingActionListItemControllerState();

  @override
  void initState() {
    super.initState();
    _cartScrollController = ScrollController();
    _cartListItemPagingController = ModifiedPagingController<int, ListItemControllerState>(
      firstPageKey: 1,
      // ignore: invalid_use_of_protected_member
      apiRequestManager: widget.cartController.apiRequestManager,
      additionalPagingResultParameterChecker: Injector.locator<CartAdditionalPagingResultParameterChecker>()
    );
    _cartListItemPagingControllerState = PagingControllerState(
      pagingController: _cartListItemPagingController,
      scrollController: _cartScrollController,
      isPagingControllerExist: false
    );
    _cartListItemPagingControllerState.pagingController.addPageRequestListenerWithItemListForLoadDataResult(
      listener: _cartListItemPagingControllerStateListener,
      onPageKeyNext: (pageKey) => pageKey + 1
    );
    _cartListItemPagingControllerState.isPagingControllerExist = true;
  }

  void _updateCartInformation() {
    _selectedCartShoppingTotal = 0;
    for (Cart cart in _selectedCartList) {
      SupportCart supportCart = cart.supportCart;
      _selectedCartShoppingTotal += supportCart.cartPrice * cart.quantity.toDouble();
    }
    if (_cartContainerInterceptingActionListItemControllerState.getCartCount != null) {
      _cartCount = _cartContainerInterceptingActionListItemControllerState.getCartCount!();
    }
  }

  Future<LoadDataResult<PagingResult<ListItemControllerState>>> _cartListItemPagingControllerStateListener(int pageKey, List<ListItemControllerState>? cartListItemControllerStateList) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _cartCount = 0);
    });
    LoadDataResult<PagingDataResult<Cart>> cartPagingLoadDataResult = await widget.cartController.getCartPaging(
      CartPagingParameter(page: pageKey)
    );
    return cartPagingLoadDataResult.map<PagingResult<ListItemControllerState>>((cartPaging) {
      List<CartListItemControllerState> newCartListItemControllerStateList = cartPaging.itemList.map<CartListItemControllerState>(
        (cart) => VerticalCartListItemControllerState(
          isSelected: false,
          cart: cart,
          onChangeQuantity: (quantity) {
            setState(() {
              int newQuantity = quantity;
              if (newQuantity < 1) {
                newQuantity = 1;
              }
              cart.quantity = newQuantity;
              _updateCartInformation();
            });
          },
          onAddToWishlist: () => widget.cartController.addToWishlist(cart.supportCart as SupportWishlist),
          onRemoveCart: () {
            widget.cartController.removeCart(cart);
            _updateCartInformation();
          },
        )
      ).toList();
      if (pageKey == 1) {
        return PagingDataResult<ListItemControllerState>(
          itemList: [
            CartContainerListItemControllerState(
              cartListItemControllerStateList: newCartListItemControllerStateList,
              onUpdateState: () => setState(() {}),
              onScrollToAdditionalItemsSection: () => _cartScrollController.jumpTo(
                _cartScrollController.position.maxScrollExtent
              ),
              additionalItemList: _additionalItemList,
              onChangeSelected: (cartList) {
                setState(() {
                  _selectedCartList = cartList;
                  _selectedCartCount = cartList.length;
                  _updateCartInformation();
                });
              },
              onCartChange: () {
                setState(() => _updateCartInformation());
                if (_cartCount == 0) {
                  _cartListItemPagingController.errorFirstPageOuterProcess = CartEmptyError();
                }
              },
              cartContainerStateStorageListItemControllerState: DefaultCartContainerStateStorageListItemControllerState(),
              cartContainerActionListItemControllerState: _DefaultCartContainerActionListItemControllerState(
                getAdditionalItemList: (additionalItemListParameter) => widget.cartController.getAdditionalItem(additionalItemListParameter),
                addAdditionalItem: (addAdditionalItemParameter) => widget.cartController.addAdditionalItem(addAdditionalItemParameter),
                changeAdditionalItem: (changeAdditionalItemParameter) => widget.cartController.changeAdditionalItem(changeAdditionalItemParameter),
                removeAdditionalItem: (removeAdditionalItemParameter) => widget.cartController.removeAdditionalItem(removeAdditionalItemParameter),
              ),
              cartContainerInterceptingActionListItemControllerState: _cartContainerInterceptingActionListItemControllerState
            )
          ],
          page: cartPaging.page,
          totalPage: cartPaging.totalPage,
          totalItem: 1
        );
      } else {
        if (ListItemControllerStateHelper.checkListItemControllerStateList(cartListItemControllerStateList)) {
          CartContainerListItemControllerState cartContainerListItemControllerState = ListItemControllerStateHelper.parsePageKeyedListItemControllerState(cartListItemControllerStateList![0]) as CartContainerListItemControllerState;
          cartContainerListItemControllerState.cartListItemControllerStateList.addAll(
            newCartListItemControllerStateList
          );
        }
        return PagingDataResult<ListItemControllerState>(
          itemList: [],
          page: cartPaging.page,
          totalPage: cartPaging.totalPage,
          totalItem: 0
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.cartController.setCartDelegate(
      CartDelegate(
        onUnfocusAllWidget: () => FocusScope.of(context).unfocus(),
        onCartBack: () => Get.back(),
        onShowAddToWishlistRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowAddToWishlistRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
        onAddToWishlistRequestProcessSuccessCallback: () async {
          ToastHelper.showToast("${"Success add to wishlist".tr}.");
        },
        onShowRemoveCartRequestProcessLoadingCallback: () async => DialogHelper.showLoadingDialog(context),
        onShowRemoveCartRequestProcessFailedCallback: (e) async => DialogHelper.showFailedModalBottomDialogFromErrorProvider(
          context: context,
          errorProvider: Injector.locator<ErrorProvider>(),
          e: e
        ),
        onRemoveCartRequestProcessSuccessCallback: (cart) async {
          if (_cartContainerInterceptingActionListItemControllerState.removeCart != null) {
            _cartContainerInterceptingActionListItemControllerState.removeCart!(cart);
          }
        },
      )
    );
    return Scaffold(
      appBar: ModifiedAppBar(
        titleInterceptor: (context, title) => Row(
          children: [
            Text("Cart".tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ModifiedPagedListView<int, ListItemControllerState>.fromPagingControllerState(
                pagingControllerState: _cartListItemPagingControllerState,
                onProvidePagedChildBuilderDelegate: (pagingControllerState) => ListItemPagingControllerStatePagedChildBuilderDelegate<int>(
                  pagingControllerState: pagingControllerState!
                ),
                pullToRefresh: true
              ),
            ),
            if (_cartCount > 0)
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Shopping Total".tr),
                                const SizedBox(height: 4),
                                Text(_selectedCartShoppingTotal.toRupiah(), style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                )),
                              ]
                            ),
                          ],
                        ),
                        const Expanded(
                          child: SizedBox()
                        ),
                        SizedOutlineGradientButton(
                          onPressed: _selectedCartCount == 0 ? null : () {
                            PageRestorationHelper.toDeliveryPage(
                              context, DeliveryPageParameter(
                                selectedCartIdList: _selectedCartList.map<List<String>>((cart) {
                                  return <String>[cart.id, cart.quantity.toString()];
                                }).toList(),
                                selectedAdditionalItemIdList: _additionalItemList.map<String>((additionalItem) {
                                  return additionalItem.id;
                                }).toList(),
                              )
                            );
                          },
                          width: 120,
                          text: "${"Checkout".tr} ($_selectedCartCount)",
                          outlineGradientButtonType: OutlineGradientButtonType.solid,
                          outlineGradientButtonVariation: OutlineGradientButtonVariation.variation2,
                        )
                      ],
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

class _DefaultCartContainerActionListItemControllerState extends CartContainerActionListItemControllerState {
  final Future<LoadDataResult<List<AdditionalItem>>> Function(AdditionalItemListParameter)? _getAdditionalItemList;
  final Future<LoadDataResult<AddAdditionalItemResponse>> Function(AddAdditionalItemParameter)? _addAdditionalItem;
  final Future<LoadDataResult<ChangeAdditionalItemResponse>> Function(ChangeAdditionalItemParameter)? _changeAdditionalItem;
  final Future<LoadDataResult<RemoveAdditionalItemResponse>> Function(RemoveAdditionalItemParameter)? _removeAdditionalItem;

  _DefaultCartContainerActionListItemControllerState({
    required Future<LoadDataResult<List<AdditionalItem>>> Function(AdditionalItemListParameter) getAdditionalItemList,
    required Future<LoadDataResult<AddAdditionalItemResponse>> Function(AddAdditionalItemParameter) addAdditionalItem,
    required Future<LoadDataResult<ChangeAdditionalItemResponse>> Function(ChangeAdditionalItemParameter) changeAdditionalItem,
    required Future<LoadDataResult<RemoveAdditionalItemResponse>> Function(RemoveAdditionalItemParameter) removeAdditionalItem,
  }) : _getAdditionalItemList = getAdditionalItemList,
      _addAdditionalItem = addAdditionalItem,
      _changeAdditionalItem = changeAdditionalItem,
      _removeAdditionalItem = removeAdditionalItem;

  @override
  Future<LoadDataResult<List<AdditionalItem>>> Function(AdditionalItemListParameter) get getAdditionalItemList => _getAdditionalItemList ?? (throw UnimplementedError());

  @override
  Future<LoadDataResult<AddAdditionalItemResponse>> Function(AddAdditionalItemParameter) get addAdditionalItem => _addAdditionalItem ?? (throw UnimplementedError());

  @override
  Future<LoadDataResult<ChangeAdditionalItemResponse>> Function(ChangeAdditionalItemParameter) get changeAdditionalItem => _changeAdditionalItem ?? (throw UnimplementedError());

  @override
  Future<LoadDataResult<RemoveAdditionalItemResponse>> Function(RemoveAdditionalItemParameter) get removeAdditionalItem => _removeAdditionalItem ?? (throw UnimplementedError());
}