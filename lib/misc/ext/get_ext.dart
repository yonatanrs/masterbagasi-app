import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';

import '../../presentation/widget/material_ignore_pointer.dart';
import '../dialog_helper.dart';
import '../getextended/extended_get_dialog_route.dart';
import '../getextended/extended_get_modal_bottom_sheet_route.dart';

extension ModifiedExtensionBottomSheet on GetInterface {
  Future<T?> bottomSheetOriginalMethod<T>(
    BuildContext context,
    Widget bottomsheet, {
      Color? backgroundColor,
      double? elevation,
      bool persistent = true,
      ShapeBorder? shape,
      Clip? clipBehavior,
      Color? barrierColor,
      bool? ignoreSafeArea,
      bool isScrollControlled = false,
      bool useRootNavigator = false,
      bool isDismissible = true,
      bool enableDrag = true,
      RouteSettings? settings,
      Duration? enterBottomSheetDuration,
      Duration? exitBottomSheetDuration,
  }) {
    Completer<T?> pushResultCompleter = Completer();
    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MaterialIgnorePointer.of(context)?.ignoring = true;
      GetModalBottomSheetRoute<T> getModalBottomSheetRoute = ExtendedGetModalBottomSheetRoute<T>(
        builder: (_) => bottomsheet,
        isPersistent: persistent,
        theme: Theme.of(key.currentContext!),
        isScrollControlled: isScrollControlled,
        barrierLabel: MaterialLocalizations.of(key.currentContext!).modalBarrierDismissLabel,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        removeTop: ignoreSafeArea ?? true,
        clipBehavior: clipBehavior,
        isDismissible: isDismissible,
        modalBarrierColor: barrierColor,
        settings: settings,
        enableDrag: enableDrag,
        enterBottomSheetDuration: enterBottomSheetDuration ?? const Duration(milliseconds: 250),
        exitBottomSheetDuration: exitBottomSheetDuration ?? const Duration(milliseconds: 200),
      );
      Future<T?> pushResult = Navigator.of(overlayContext!, rootNavigator: useRootNavigator).push(getModalBottomSheetRoute);
      pushResultCompleter.complete(pushResult);
    });
    return pushResultCompleter.future;
  }
}

extension ModifiedExtensionDialog on GetInterface {
  Future<T?> dialogOriginalMethod<T>(
    BuildContext context,
    Widget dialog, {
      bool barrierDismissible = true,
      Color? barrierColor = Colors.black54,
      String? barrierLabel,
      bool useSafeArea = true,
      bool useRootNavigator = true,
      RouteSettings? routeSettings,
      Offset? anchorPoint,
  }) {
    Completer<T?> pushResultCompleter = Completer();
    FocusScope.of(context).unfocus();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      MaterialIgnorePointer.of(context)?.ignoring = true;
      final CapturedThemes themes = InheritedTheme.capture(
        from: context,
        to: Navigator.of(
          context,
          rootNavigator: useRootNavigator,
        ).context,
      );
      DialogRoute<T> dialogRoute = ExtendedGetDialogRoute<T>(
        context: context,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(16.0),
          child: dialog,
        ),
        barrierColor: barrierColor,
        barrierDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        settings: routeSettings,
        themes: themes,
        anchorPoint: anchorPoint,
      );
      Future<T?> pushResult = Navigator.of(overlayContext!, rootNavigator: useRootNavigator).push(dialogRoute);
      pushResultCompleter.complete(pushResult);
    });
    return pushResultCompleter.future;
  }
}