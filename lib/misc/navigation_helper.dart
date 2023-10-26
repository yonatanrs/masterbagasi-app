import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/navigator_ext.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/string_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../domain/entity/order/order.dart';
import '../presentation/widget/material_ignore_pointer.dart';
import 'constant.dart';
import 'dialog_helper.dart';
import 'main_route_observer.dart';
import 'page_restoration_helper.dart';
import 'routeargument/login_route_argument.dart';
import 'routeargument/main_menu_route_argument.dart';

class _NavigationHelperImpl {
  void navigationAfterPurchaseProcess(BuildContext context, Order order) {
    Map<String, RouteWrapper?> routeMap = MainRouteObserver.routeMap;
    List<String> routeKeyList = List.of(routeMap.keys);
    int i = 0;
    int? beforeI;
    for (var element in routeMap.entries) {
      var arguments = element.value?.route?.settings.arguments;
      if (arguments is MainMenuRouteArgument) {
        beforeI = i + 1;
        break;
      }
      i++;
    }
    String mainMenuRouteKey = routeKeyList[i];
    while (true) {
      if (beforeI != null) {
        if (beforeI >= 0) {
          String routeKey = routeKeyList[beforeI];
          Route<dynamic>? targetRoute = routeMap[routeKey]?.route;
          if (targetRoute != null) {
            if (!targetRoute.settings.name.isEmptyString) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                MaterialIgnorePointer.of(context)?.ignoring = true;
                String targetRouteName = (targetRoute.settings.name).toEmptyStringNonNull;
                MainRouteObserver.disposingEventRouteMap[targetRouteName] = () {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
                    BuildContext Function()? buildContextEventFunction = MainRouteObserver.buildContextEventRouteMap[mainMenuRouteKey];
                    if (buildContextEventFunction != null) {
                      BuildContext mainMenuBuildContext = buildContextEventFunction();
                      MaterialIgnorePointer.of(mainMenuBuildContext)?.ignoring = false;
                      DialogHelper.showLoadingDialog(mainMenuBuildContext);
                      await launchUrl(
                        Uri.parse("https://app.midtrans.com/snap/v2/vtweb/${order.combinedOrder.orderProduct.orderDetail.snapToken}"),
                        mode: LaunchMode.inAppWebView
                      );
                      Get.back();
                    }
                    MainRouteObserver.disposingEventRouteMap[targetRouteName] = null;
                  });
                };
              });
              Navigator.of(context).popUntilMainMenu();
              break;
            }
          }
          beforeI += 1;
        } else {
          break;
        }
      } else {
        break;
      }
    }
  }

  void navigationAfterRegisterProcess(BuildContext context) {
    Map<String, RouteWrapper?> routeMap = MainRouteObserver.routeMap;
    List<String> routeKeyList = List.of(routeMap.keys);
    int i = 0;
    int? beforeI;
    for (var element in routeMap.entries) {
      element.value?.requestLoginChangeValue = 1;
      var arguments = element.value?.route?.settings.arguments;
      if (arguments is LoginRouteArgument) {
        beforeI = i - 1;
        break;
      }
      i++;
    }
    while (true) {
      if (beforeI != null) {
        if (beforeI >= 0) {
          String routeKey = routeKeyList[beforeI];
          Route<dynamic>? targetRoute = routeMap[routeKey]?.route;
          if (targetRoute != null) {
            if (!targetRoute.settings.name.isEmptyString) {
              String targetRouteName = (targetRoute.settings.name).toEmptyStringNonNull;
              Navigator.of(context).popUntil((route) => route.settings.name == targetRouteName);
              break;
            }
          }
          beforeI -= 1;
        } else {
          break;
        }
      } else {
        break;
      }
    }
  }
}

// ignore: non_constant_identifier_names
final _NavigationHelperImpl NavigationHelper = _NavigationHelperImpl();