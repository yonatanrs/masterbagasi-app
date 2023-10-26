import 'package:flutter/material.dart';

class ShimmerCustomEffectMarker extends InheritedWidget {
  const ShimmerCustomEffectMarker({
    Key? key,
    required Widget child
  }) : super(
    key: key,
    child: child
  );

  static ShimmerCustomEffectMarker? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShimmerCustomEffectMarker>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}