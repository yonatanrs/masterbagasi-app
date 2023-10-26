import 'package:flutter/material.dart';

import '../../misc/main_route_observer.dart';

class SomethingCounter extends StatefulWidget {
  // ignore: library_private_types_in_public_api
  static _SomethingCounterState? of(BuildContext context) {
    return context.findAncestorStateOfType<_SomethingCounterState>();
  }

  final Widget child;

  const SomethingCounter({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<SomethingCounter> createState() => _SomethingCounterState();
}

class _SomethingCounterState extends State<SomethingCounter> with RestorationMixin {
  final RestorableRouteKeyMap routeKeyMap = RestorableRouteKeyMap();

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  String? get restorationId => "something-counter";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(routeKeyMap, 'route-key-map');
    MainRouteObserver.applyNewRouteMapFromRouteKeyMap(routeKeyMap.value.key);
  }
}

class RestorableRouteKeyMap extends RestorableValue<RouteKeyMapValue> {
  @override
  RouteKeyMapValue createDefaultValue() => RouteKeyMapValue(key: {});

  @override
  void didUpdateValue(RouteKeyMapValue? oldValue) {
    notifyListeners();
  }

  @override
  RouteKeyMapValue fromPrimitives(Object? data) {
    //print("FROM PRIMITIVE: $data");
    List<String> key = (data as String).split("|");
    Map<String, int> result = {};
    for (int i = 0; i < key.length; i++) {
      result[key[i]] = 1;
    }
    return RouteKeyMapValue(key: result);
  }

  @override
  Object? toPrimitives() {
    String result = "";
    int i = 0;
    value.key.forEach((key, value) {
      result += "${(i > 0 ? "|" : "")}$key";
      i++;
    });
    //print("TO PRIMITIVE: $result");
    return result;
  }
}

class RouteKeyMapValue {
  Map<String, int> key;

  RouteKeyMapValue({
    required this.key
  });

  RouteKeyMapValue copy({
    Map<String, int>? key
  }) {
    return RouteKeyMapValue(
      key: key ?? this.key
    );
  }
}