import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routeargument/login_route_argument.dart';
import '../routeargument/main_menu_route_argument.dart';

extension NavigatorStateExt on NavigatorState {
  void popUntilLogin() {
    popUntil(popUntilLoginPredicate());
  }

  void popUntilMainMenu() {
    popUntil(popUntilMainMenuPredicate());
  }

  RoutePredicate popUntilLoginPredicate() {
    return (route) {
      if (route is GetPageRoute) {
        if (route.settings.arguments is LoginRouteArgument) {
          return true;
        }
      }
      return false;
    };
  }

  RoutePredicate popUntilMainMenuPredicate() {
    return (route) {
      if (route is GetPageRoute) {
        if (route.settings.arguments is MainMenuRouteArgument) {
          return true;
        }
      }
      return false;
    };
  }
}