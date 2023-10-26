import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/widget/something_counter.dart';
import 'refresh_delivery_review.dart';

class _MainRouteObserver extends RouteObserver {
  Map<String, RouteWrapper?> _routeMap = {};
  Map<String, RouteWrapper?> get routeMap => _routeMap;
  Map<String, void Function()?> _disposingEventRouteMap = {};
  Map<String, void Function()?> get disposingEventRouteMap => _disposingEventRouteMap;
  Map<String, BuildContext Function()?> _buildContextEventRouteMap = {};
  Map<String, BuildContext Function()?> get buildContextEventRouteMap => _buildContextEventRouteMap;
  Map<String, void Function()?> _controllerMediatorMap = {};
  Map<String, void Function()?> get controllerMediatorMap => _controllerMediatorMap;
  void Function(int)? onChangeMainMenuTap;
  void Function()? onRefreshWishlistInMainMenu;
  void Function()? onRefreshAddress;
  void Function()? onRefreshCartInMainMenu;
  RefreshDeliveryReview? onRefreshDeliveryReview;

  void applyNewRouteMapFromRouteKeyMap(Map<String, int> newRouteMap) {
    _routeMap = {
      for (var key in newRouteMap.keys) key: RouteWrapper(
        restorationValue: newRouteMap[key] ?? 1,
        requestLoginChangeValue: 0
      )
    };
    _disposingEventRouteMap = {
      for (var key in newRouteMap.keys) key: null
    };
    _buildContextEventRouteMap = {
      for (var key in newRouteMap.keys) key: null
    };
    _controllerMediatorMap = {
      for (var key in newRouteMap.keys) key: null
    };
  }

  void _updateModifyRouteKeyMapValue(Route route) {
    BuildContext? context = route.navigator?.context;
    if (context != null) {
      RouteKeyMapValue? routeKeyMapValue = SomethingCounter.of(context)?.routeKeyMap.value;
      if (routeKeyMapValue != null) {
        routeKeyMapValue.key = {
          for (var key in _routeMap.keys) key: 0
        };
        SomethingCounter.of(context)?.routeKeyMap.value = routeKeyMapValue.copy();
      }
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    String? previousKeyMap = previousRoute?.settings.name;
    if (routeMap.containsKey(previousKeyMap)) {
      RouteWrapper routeWrapper = routeMap[previousKeyMap]!;
      if (routeWrapper.requestLoginChangeValue == 1) {
        routeWrapper.requestLoginChangeValue = 0;
        if (routeWrapper.onLoginChange != null) {
          routeWrapper.onLoginChange!();
        }
      }
    }
    String? keyMap = route.settings.name;
    _routeMap[keyMap]?.onLoginChange = null;
    _routeMap.remove(keyMap);
    _updateModifyRouteKeyMapValue(route);
    //print("Pop Route: $route");
    _showRouteMap();
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _routeMap[route.settings.name ?? ""] = RouteWrapper(
      route: route,
      restorationValue: 0,
      requestLoginChangeValue: 0
    );
    _updateModifyRouteKeyMapValue(route);
    //print("Push Route: $route");
    _showRouteMap();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _routeMap.remove(route.settings.name);
    _updateModifyRouteKeyMapValue(route);
    //print("Remove Route: $route");
    _showRouteMap();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      _routeMap.remove(oldRoute.settings.name);
      _updateModifyRouteKeyMapValue(oldRoute);
    }
    if (newRoute != null) {
      _routeMap[newRoute.settings.name ?? ""] = RouteWrapper(
        route: newRoute,
        restorationValue: 0,
        requestLoginChangeValue: 0
      );
      _updateModifyRouteKeyMapValue(newRoute);
    }
    //print("Replace Route: $newRoute");
    _showRouteMap();
  }

  void _showRouteMap() {
    // print("");
    // print("Route Map:");
    // _routeMap.forEach((key, value) {
    //   print("Key: $key, Value: $value");
    // });
    // print("");
  }

  bool checkRouteNameExists(String routeName) {
    return _routeMap.containsKey(routeName);
  }
}

// ignore: library_private_types_in_public_api, non_constant_identifier_names
final _MainRouteObserver MainRouteObserver = _MainRouteObserver();

class RouteWrapper {
  Route? route;
  int restorationValue;
  int requestLoginChangeValue;
  void Function()? onLoginChange;

  RouteWrapper({
    this.route,
    required this.restorationValue,
    required this.requestLoginChangeValue,
    this.onLoginChange,
  });
}