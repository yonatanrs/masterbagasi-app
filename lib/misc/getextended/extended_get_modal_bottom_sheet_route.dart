import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/bottomsheet/bottomsheet.dart';

import '../../presentation/widget/material_ignore_pointer.dart';

typedef RoutePageBuilderInterceptor = Widget Function(Widget builtWidget, BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation);

class ExtendedGetModalBottomSheetRoute<T> extends GetModalBottomSheetRoute<T> {
  RoutePageBuilderInterceptor? routePageBuilderInterceptor;

  ExtendedGetModalBottomSheetRoute({
    WidgetBuilder? builder,
    ThemeData? theme,
    String? barrierLabel,
    Color? backgroundColor,
    bool? isPersistent,
    double? elevation,
    ShapeBorder? shape,
    bool removeTop = true,
    Clip? clipBehavior,
    Color? modalBarrierColor,
    bool isDismissible = true,
    bool enableDrag = true,
    required bool isScrollControlled,
    RouteSettings? settings,
    Duration enterBottomSheetDuration = const Duration(milliseconds: 250),
    Duration exitBottomSheetDuration = const Duration(milliseconds: 200),
    this.routePageBuilderInterceptor
  }) : super(
    builder: builder,
    theme: theme,
    barrierLabel: barrierLabel,
    backgroundColor: backgroundColor,
    isPersistent: isPersistent,
    elevation: elevation,
    shape: shape,
    removeTop: removeTop,
    clipBehavior: clipBehavior,
    modalBarrierColor: modalBarrierColor,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    isScrollControlled: isScrollControlled,
    settings: settings,
    enterBottomSheetDuration: enterBottomSheetDuration,
    exitBottomSheetDuration: exitBottomSheetDuration,
  );

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    Widget builtWidget = super.buildPage(context, animation, secondaryAnimation);
    return routePageBuilderInterceptor != null ? routePageBuilderInterceptor!(
      builtWidget, context, animation, secondaryAnimation
    ) : ExtendedGetModalBottomSheetWidget(
      child: builtWidget,
      animation: animation,
      secondaryAnimation: secondaryAnimation
    );
  }
}

class ExtendedGetModalBottomSheetWidget extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;
  final Animation<double> secondaryAnimation;

  const ExtendedGetModalBottomSheetWidget({
    Key? key,
    required this.child,
    required this.animation,
    required this.secondaryAnimation
  }) : super(key: key);

  @override
  ExtendedGetModalBottomSheetWidgetState createState() => ExtendedGetModalBottomSheetWidgetState();
}

class ExtendedGetModalBottomSheetWidgetState extends State<ExtendedGetModalBottomSheetWidget> {
  bool _hasCreatedAnimationStatusListener = false;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!_hasCreatedAnimationStatusListener) {
        _hasCreatedAnimationStatusListener = true;
        widget.animation.addStatusListener((animationStatus) {
          var materialIgnorePointerState = MaterialIgnorePointer.of(context);
          if (animationStatus == AnimationStatus.completed) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              materialIgnorePointerState?.ignoring = false;
            });
          } else if (animationStatus == AnimationStatus.dismissed) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              materialIgnorePointerState?.resetIgnoring();
            });
          }
        });
      }
    });
    return WillPopScope(
      onWillPop: () {
        Completer<bool> boolCompleter = Completer();
        MaterialIgnorePointer.of(context)?.ignoring = true;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          boolCompleter.complete(true);
        });
        return boolCompleter.future;
      },
      child: widget.child
    );
  }
}