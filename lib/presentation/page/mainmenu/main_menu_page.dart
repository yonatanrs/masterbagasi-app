import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/presentation/page/product_detail_page.dart';

import '../../../controller/base_getx_controller.dart';
import '../../../controller/mainmenucontroller/main_menu_controller.dart';
import '../../../controller/mainmenucontroller/mainmenusubpagecontroller/explore_nusantara_main_menu_sub_controller.dart';
import '../../../controller/mainmenucontroller/mainmenusubpagecontroller/feed_main_menu_sub_controller.dart';
import '../../../controller/mainmenucontroller/mainmenusubpagecontroller/home_main_menu_sub_controller.dart';
import '../../../controller/mainmenucontroller/mainmenusubpagecontroller/menu_main_menu_sub_controller.dart';
import '../../../controller/mainmenucontroller/mainmenusubpagecontroller/wishlist_main_menu_sub_controller.dart';
import '../../../misc/constant.dart';
import '../../../misc/dialog_helper.dart';
import '../../../misc/getextended/get_extended.dart';
import '../../../misc/getextended/get_restorable_route_future.dart';
import '../../../misc/injector.dart';
import '../../../misc/login_helper.dart';
import '../../../misc/main_route_observer.dart';
import '../../../misc/manager/controller_manager.dart';
import '../../../misc/page_restoration_helper.dart';
import '../../../misc/routeargument/main_menu_route_argument.dart';
import '../../../misc/typedef.dart';
import '../../widget/custom_bottom_navigation_bar.dart';
import '../../widget/modified_svg_picture.dart';
import '../../widget/rx_consumer.dart';
import '../address_page.dart';
import '../affiliate_page.dart';
import '../cart_page.dart';
import '../country_delivery_review_page.dart';
import '../deliveryreview/delivery_review_page.dart';
import '../favorite_product_brand_page.dart';
import '../help_page.dart';
import '../inbox_page.dart';
import '../login_page.dart';
import '../getx_page.dart';
import '../msme_partner_page.dart';
import '../notification_page.dart';
import '../order_page.dart';
import '../product_brand_page.dart';
import '../product_bundle_detail_page.dart';
import '../product_bundle_page.dart';
import '../product_category_detail_page.dart';
import '../product_discussion_page.dart';
import '../product_entry_page.dart';
import '../search_page.dart';
import '../web_viewer_page.dart';
import 'mainmenusubpage/explore_nusantara_main_menu_page.dart';
import 'mainmenusubpage/feed_main_menu_sub_page.dart';
import 'mainmenusubpage/home_main_menu_sub_page.dart';
import 'mainmenusubpage/menu_main_menu_sub_page.dart';
import 'mainmenusubpage/wishlist_main_menu_sub_page.dart';

class MainMenuPage extends RestorableGetxPage<_MainMenuPageRestoration> {
  late final ControllerMember<MainMenuController> _mainMenuController = ControllerMember<MainMenuController>().addToControllerManager(controllerManager);
  late final List<List<dynamic>> _mainMenuSubControllerList;

  MainMenuPage({Key? key}) : super(key: key, pageRestorationId: () => "main-menu-page") {
    _mainMenuSubControllerList = [
      [
        ControllerMember<HomeMainMenuSubController>().addToControllerManager(controllerManager),
        () => Injector.locator<HomeMainMenuSubControllerInjectionFactory>().inject(controllerManager, pageName),
        () {
          void Function()? onRefresh = MainRouteObserver.controllerMediatorMap[Constant.subPageKeyHomeMainMenu];
          if (onRefresh != null) {
            onRefresh();
          }
        }
      ],
      [
        ControllerMember<FeedMainMenuSubController>().addToControllerManager(controllerManager),
        () => Injector.locator<FeedMainMenuSubControllerInjectionFactory>().inject(controllerManager, pageName),
        () {
          void Function()? onRefresh = MainRouteObserver.controllerMediatorMap[Constant.subPageKeyFeedMainMenu];
          if (onRefresh != null) {
            onRefresh();
          }
        }
      ],
      [
        ControllerMember<ExploreNusantaraMainMenuSubController>().addToControllerManager(controllerManager),
        () => Injector.locator<ExploreNusantaraMainMenuSubControllerInjectionFactory>().inject(controllerManager, pageName),
        () {
          void Function()? onRefresh = MainRouteObserver.controllerMediatorMap[Constant.subPageKeyExploreNusantaraMainMenu];
          if (onRefresh != null) {
            onRefresh();
          }
        }
      ],
      [
        ControllerMember<WishlistMainMenuSubController>().addToControllerManager(controllerManager),
        () => Injector.locator<WishlistMainMenuSubControllerInjectionFactory>().inject(controllerManager, pageName),
        () {
          void Function()? onRefresh = MainRouteObserver.controllerMediatorMap[Constant.subPageKeyWishlistMainMenu];
          if (onRefresh != null) {
            onRefresh();
          }
        }
      ],
      [
        ControllerMember<MenuMainMenuSubController>().addToControllerManager(controllerManager),
        () => Injector.locator<MenuMainMenuSubControllerInjectionFactory>().inject(controllerManager, pageName),
        () {
          void Function()? onRefresh = MainRouteObserver.controllerMediatorMap[Constant.subPageKeyMenuMainMenu];
          if (onRefresh != null) {
            onRefresh();
          }
        }
      ]
    ];
  }

  @override
  void onSetController() {
    _mainMenuController.controller = GetExtended.put<MainMenuController>(MainMenuController(controllerManager), tag: pageName);
    for (var mainMenuSubController in _mainMenuSubControllerList) {
      (mainMenuSubController[0] as ControllerMember).controller = (mainMenuSubController[1] as GetControllerFromGetPut)();
    }
  }

  @override
  _MainMenuPageRestoration createPageRestoration() => _MainMenuPageRestoration(
    onCompleteAddressPage: (result) {
      if (result != null) {
        if (result) {
          if (MainRouteObserver.onRefreshAddress != null) {
            MainRouteObserver.onRefreshAddress!();
          }
        }
      }
    }
  );

  @override
  void onLoginChange() {
    _mainMenuController.controller.checkLoginStatus(reset: true);
    for (var mainMenuSubController in _mainMenuSubControllerList) {
      mainMenuSubController[2]();
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return _StatefulMainMenuControllerMediatorWidget(
      mainMenuController: _mainMenuController.controller,
      mainMenuSubControllerList: _mainMenuSubControllerList,
      pageName: pageName,
    );
  }
}

class _MainMenuPageRestoration extends MixableGetxPageRestoration with MainMenuPageRestorationMixin, LoginPageRestorationMixin, ProductEntryPageRestorationMixin, ProductDetailPageRestorationMixin, ProductCategoryDetailPageRestorationMixin, ProductBundlePageRestorationMixin, ProductBundleDetailPageRestorationMixin, CartPageRestorationMixin, ProductBrandPageRestorationMixin, WebViewerPageRestorationMixin, OrderPageRestorationMixin, DeliveryReviewPageRestorationMixin, FavoriteProductBrandPageRestorationMixin, ProductDiscussionPageRestorationMixin, MainMenuPageRestorationMixin, AddressPageRestorationMixin, InboxPageRestorationMixin, AffiliatePageRestorationMixin, MsmePartnerPageRestorationMixin, CountryDeliveryReviewPageRestorationMixin, HelpPageRestorationMixin, SearchPageRestorationMixin, NotificationPageRestorationMixin {
  final RouteCompletionCallback<bool?>? _onCompleteAddressPage;

  _MainMenuPageRestoration({
    RouteCompletionCallback<bool?>? onCompleteAddressPage
  }) : _onCompleteAddressPage = onCompleteAddressPage;

  @override
  // ignore: unnecessary_overrides
  void initState() {
    onCompleteSelectAddress = _onCompleteAddressPage;
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

mixin MainMenuPageRestorationMixin on MixableGetxPageRestoration {
  late MainMenuPageRestorableRouteFuture mainMenuPageRestorableRouteFuture;

  @override
  void initState() {
    super.initState();
    mainMenuPageRestorableRouteFuture = MainMenuPageRestorableRouteFuture(restorationId: restorationIdWithPageName('main-menu-page-route'));
  }

  @override
  void restoreState(Restorator restorator, RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(restorator, oldBucket, initialRestore);
    mainMenuPageRestorableRouteFuture.restoreState(restorator, oldBucket, initialRestore);
  }

  @override
  void dispose() {
    super.dispose();
    mainMenuPageRestorableRouteFuture.dispose();
  }
}

class MainMenuPageGetPageBuilderAssistant extends GetPageBuilderAssistant {
  @override
  GetPageBuilder get pageBuilder => (() => MainMenuPage());

  @override
  GetPageBuilder get pageWithOuterGetxBuilder => (() => GetxPageBuilder.buildRestorableGetxPage(MainMenuPage()));
}

class MainMenuPageRestorableRouteFuture extends GetRestorableRouteFuture {
  late RestorableRouteFuture<void> _pageRoute;

  MainMenuPageRestorableRouteFuture({required String restorationId}) : super(restorationId: restorationId) {
    _pageRoute = RestorableRouteFuture<void>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        if (arguments is String) {
          if (arguments == Constant.restorableRouteFuturePushAndRemoveUntil) {
            return navigator.restorablePushAndRemoveUntil(_pageRouteBuilder, (route) => false, arguments: arguments);
          } else {
            return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
          }
        } else {
          return navigator.restorablePush(_pageRouteBuilder, arguments: arguments);
        }
      },
    );
  }

  static Route<void>? getRoute([Object? arguments]) {
    return GetExtended.toWithGetPageRouteReturnValue<void>(
      GetxPageBuilder.buildRestorableGetxPageBuilder(MainMenuPageGetPageBuilderAssistant()),
      arguments: MainMenuRouteArgument(),
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _pageRouteBuilder(BuildContext context, Object? arguments) {
    return getRoute(arguments)!;
  }

  @override
  bool checkBeforePresent([Object? arguments]) => getRoute(arguments) != null;

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

class _StatefulMainMenuControllerMediatorWidget extends StatefulWidget {
  final MainMenuController mainMenuController;
  final List<List<dynamic>> mainMenuSubControllerList;
  final String pageName;

  const _StatefulMainMenuControllerMediatorWidget({
    required this.mainMenuController,
    required this.mainMenuSubControllerList,
    required this.pageName
  });

  @override
  State<_StatefulMainMenuControllerMediatorWidget> createState() => _StatefulMainMenuControllerMediatorWidgetState();
}

class _StatefulMainMenuControllerMediatorWidgetState extends State<_StatefulMainMenuControllerMediatorWidget> {
  late CustomBottomNavigationBarSelectedIndex _customBottomNavigationBarSelectedIndex;
  final TapGestureRecognizer _signInTapGestureRecognizer = TapGestureRecognizer();

  @override
  void initState() {
    super.initState();
    _onItemTapped(
      CustomBottomNavigationBarSelectedIndex(
        currentSelectedViewMenuIndex: 0,
        currentSelectedMenuIndex: 0
      )
    );
    MainRouteObserver.onChangeMainMenuTap = (index) => _onItemTappedWithContext(
      CustomBottomNavigationBarSelectedIndex(
        currentSelectedMenuIndex: index,
        currentSelectedViewMenuIndex: index
      ),
      context
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.mainMenuController.setMainMenuDelegate(
      MainMenuDelegate(
        onGetLoginStatus: () => LoginHelper.getTokenWithBearer().result.isNotEmptyString
      )
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.mainMenuController.checkLoginStatus();
    });
    return Material(
      child: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _customBottomNavigationBarSelectedIndex.currentSelectedViewMenuIndex,
              children: [
                HomeMainMenuSubPage(ancestorPageName: widget.pageName),
                FeedMainMenuSubPage(ancestorPageName: widget.pageName),
                ExploreNusantaraMainMenuSubPage(ancestorPageName: widget.pageName),
                WishlistMainMenuSubPage(ancestorPageName: widget.pageName),
                MenuMainMenuSubPage(ancestorPageName: widget.pageName),
              ],
            )
          ),
          RxConsumer<bool>(
            rxValue: widget.mainMenuController.isLoginRx,
            onConsumeValue: (context, isLogin) => !isLogin ? Container(
              color: Constant.colorLightRed,
              padding: EdgeInsets.all(Constant.paddingListItem),
              child: Row(
                children: [
                  ModifiedSvgPicture.asset(Constant.vectorBag, overrideDefaultColorWithSingleColor: false),
                  const SizedBox(width: 10),
                  Builder(
                    builder: (context) {
                      _signInTapGestureRecognizer.onTap = () => PageRestorationHelper.toLoginPage(context, Constant.restorableRouteFuturePush);
                      return Text.rich("Miss Indonesian Food".trTextSpan(parameter: _signInTapGestureRecognizer));
                    }
                  )
                ]
              ),
            ) : Container(),
          ),
          CustomBottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _customBottomNavigationBarSelectedIndex.currentSelectedMenuIndex,
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
            onTap: (selectedIndex) => _onItemTappedWithContext(selectedIndex, context),
            items: [
              CustomBottomNavigationBarItem(
                icon: ModifiedSvgPicture.asset(Constant.vectorHomeUnselected, overrideDefaultColorWithSingleColor: false),
                activeIcon: ModifiedSvgPicture.asset(Constant.vectorHomeSelected, overrideDefaultColorWithSingleColor: false),
                label: 'Home'.tr,
                hideLabelWhenInactive: false,
              ),
              CustomBottomNavigationBarItem(
                icon: ModifiedSvgPicture.asset(Constant.vectorFeedUnselected, overrideDefaultColorWithSingleColor: false),
                activeIcon: ModifiedSvgPicture.asset(Constant.vectorFeedSelected, overrideDefaultColorWithSingleColor: false),
                label: 'Feed'.tr,
                hideLabelWhenInactive: false
              ),
              CustomBottomNavigationBarItem(
                icon: ModifiedSvgPicture.asset(Constant.vectorExploreUnselected, overrideDefaultColorWithSingleColor: false),
                activeIcon: ModifiedSvgPicture.asset(Constant.vectorExploreSelected, overrideDefaultColorWithSingleColor: false),
                label: 'Explore'.tr,
                hideLabelWhenInactive: false
              ),
              CustomBottomNavigationBarItem(
                icon: ModifiedSvgPicture.asset(Constant.vectorWishlistUnselected, overrideDefaultColorWithSingleColor: false),
                activeIcon: ModifiedSvgPicture.asset(Constant.vectorWishlistSelected, overrideDefaultColorWithSingleColor: false),
                label: 'Wishlist'.tr,
                hideLabelWhenInactive: false
              ),
              CustomBottomNavigationBarItem(
                icon: ModifiedSvgPicture.asset(Constant.vectorMenuUnselected, overrideDefaultColorWithSingleColor: false),
                activeIcon: ModifiedSvgPicture.asset(Constant.vectorMenuSelected, overrideDefaultColorWithSingleColor: false),
                label: 'Menu'.tr,
                hideLabelWhenInactive: false
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onItemTapped(CustomBottomNavigationBarSelectedIndex selectedIndex) {
    _customBottomNavigationBarSelectedIndex = selectedIndex;
    _firstInitTabChildWidget(selectedIndex);
  }

  void _onItemTappedWithContext(CustomBottomNavigationBarSelectedIndex selectedIndex, BuildContext context) {
    _customBottomNavigationBarSelectedIndex = selectedIndex;
    _firstInitTabChildWidget(selectedIndex);
    setState(() {});
  }

  void _firstInitTabChildWidget(CustomBottomNavigationBarSelectedIndex selectedIndex) {
    int selectedViewIndex = selectedIndex.currentSelectedViewMenuIndex;
    dynamic controller = (widget.mainMenuSubControllerList[selectedViewIndex][0] as ControllerMember).controller;
    if (controller is BaseGetxController) {
      if (!controller.hasInitController()) {
        controller.initController();
      }
    }
  }

  @override
  void dispose() {
    MainRouteObserver.onRefreshAddress = null;
    MainRouteObserver.onRefreshCartInMainMenu = null;
    MainRouteObserver.onRefreshWishlistInMainMenu = null;
    super.dispose();
  }
}