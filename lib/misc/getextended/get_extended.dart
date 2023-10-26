import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:masterbagasi/misc/translation/extended_translation.dart';
import '../../controller/base_getx_controller.dart';
import '../../presentation/page/getx_page.dart';
import '../main_route_observer.dart';
import '../manager/controller_manager.dart';
import 'getx_controller_will_be_deleted.dart';

class _GetExtendedImpl {
  String sanitizeNewRestorationIdName(String newRestorationId) {
    String sanitizedNewRestorationIdName = "";
    int step = 1;
    for (int i = 0; i < newRestorationId.length; i++) {
      String c = newRestorationId[i];
      if (step == 1) {
        if (c == '/') {
          step = 2;
        }
      } else {
        sanitizedNewRestorationIdName += c;
      }
    }
    return sanitizedNewRestorationIdName;
  }

  String cleanRouteName(String name) {
    name = name.replaceAll('() => ', '');

    /// uncommonent for URL styling.
    // name = name.paramCase!;
    if (!name.startsWith('/')) {
      name = '/$name';
    }
    return Uri.tryParse(name)?.toString() ?? name;
  }

  GetPageBuilder _resolvePage(dynamic page, String method) {
    if (page is GetPageBuilder) {
      return page;
    } else if (page is GetPageBuilderWithPageName) {
      return page.builder;
    } else if (page is Widget) {
      Get.log(
          '''WARNING, consider using: "Get.$method(() => Page())" instead of "Get.$method(Page())".
Using a widget function instead of a widget fully guarantees that the widget and its controllers will be removed from memory when they are no longer used.
      ''');
      return () => page;
    } else if (page is String) {
      throw '''Unexpected String,
use toNamed() instead''';
    } else {
      throw '''Unexpected format,
you can only use widgets and widget functions here''';
    }
  }

  Future<T?>? off<T, C extends BaseGetxController>(
    dynamic page, {
      required List<GetxControllerWillBeDeleted> getxControllerWillBeDeleted,
      bool opaque = false,
      Transition? transition,
      Curve? curve,
      bool? popGesture,
      int? id,
      String? routeName,
      dynamic arguments,
      Bindings? binding,
      bool fullscreenDialog = false,
      bool preventDuplicates = true,
      Duration? duration,
      double Function(BuildContext context)? gestureWidth,
    }
  ) {
    GetxControllerWillBeDeletedProcessor.delete(getxControllerWillBeDeleted);
    return Get.off<T>(
      page,
      opaque: opaque,
      transition: transition,
      curve: curve,
      popGesture: popGesture,
      id: id,
      routeName: routeName,
      arguments: arguments,
      binding: binding,
      fullscreenDialog: fullscreenDialog,
      preventDuplicates: preventDuplicates,
      duration: duration,
      gestureWidth: gestureWidth
    );
  }

  Future<T?>? offWithControllerManager<T, C extends BaseGetxController>(
    dynamic page, {
      required ControllerManager? controllerManager,
      bool opaque = false,
      Transition? transition,
      Curve? curve,
      bool? popGesture,
      int? id,
      String? routeName,
      dynamic arguments,
      Bindings? binding,
      bool fullscreenDialog = false,
      bool preventDuplicates = true,
      Duration? duration,
      double Function(BuildContext context)? gestureWidth,
    }
  ) {
    controllerManager?.dispose();
    return Get.off<T>(
      page,
      opaque: opaque,
      transition: transition,
      curve: curve,
      popGesture: popGesture,
      id: id,
      routeName: routeName,
      arguments: arguments,
      binding: binding,
      fullscreenDialog: fullscreenDialog,
      preventDuplicates: preventDuplicates,
      duration: duration,
      gestureWidth: gestureWidth
    );
  }

  Future<T?>? offAll<T, C extends BaseGetxController>(
    dynamic page, {
      required List<GetxControllerWillBeDeleted> getxControllerWillBeDeleted,
      bool opaque = false,
      Transition? transition,
      Curve? curve,
      bool? popGesture,
      int? id,
      String? routeName,
      dynamic arguments,
      Bindings? binding,
      bool fullscreenDialog = false,
      bool preventDuplicates = true,
      Duration? duration,
      double Function(BuildContext context)? gestureWidth,
    }
  ) {
    GetxControllerWillBeDeletedProcessor.delete(getxControllerWillBeDeleted);
    return Get.offAll(
      page,
      opaque: opaque,
      transition: transition,
      curve: curve,
      popGesture: popGesture,
      id: id,
      routeName: routeName,
      arguments: arguments,
      binding: binding,
      fullscreenDialog: fullscreenDialog,
      duration: duration,
      gestureWidth: gestureWidth
    );
  }

  Future<T?>? offAllWithControllerManager<T, C extends BaseGetxController>(
    dynamic page, {
      required ControllerManager? controllerManager,
      bool opaque = false,
      Transition? transition,
      Curve? curve,
      bool? popGesture,
      int? id,
      String? routeName,
      dynamic arguments,
      Bindings? binding,
      bool fullscreenDialog = false,
      bool preventDuplicates = true,
      Duration? duration,
      double Function(BuildContext context)? gestureWidth,
    }
  ) {
    controllerManager?.dispose();
    return Get.offAll(
      page,
      opaque: opaque,
      transition: transition,
      curve: curve,
      popGesture: popGesture,
      id: id,
      routeName: routeName,
      arguments: arguments,
      binding: binding,
      fullscreenDialog: fullscreenDialog,
      duration: duration,
      gestureWidth: gestureWidth
    );
  }

  void backWithControllerManager<T>({
    required ControllerManager? controllerManager,
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    controllerManager?.dispose();
    Get.back(
      result: result,
      closeOverlays: closeOverlays,
      canPop: canPop,
      id: id
    );
  }

  Route<T>? toWithGetPageRouteReturnValue<T>(
    dynamic page, {
      bool? opaque,
      Transition? transition,
      Curve? curve,
      Duration? duration,
      int? id,
      String? routeName,
      bool fullscreenDialog = false,
      dynamic arguments,
      Bindings? binding,
      bool preventDuplicates = true,
      bool? popGesture,
      double Function(BuildContext context)? gestureWidth,
    }
  ) {
    // var routeName = "/${page.runtimeType}";
    if (page is GetPageBuilderWithPageName) {
      routeName ??= "/${page.pageName}";
    } else {
      routeName ??= "/${page.runtimeType}";
    }
    routeName = cleanRouteName(routeName);
    if (preventDuplicates && routeName == Get.currentRoute) {
      return null;
    }
    return ExtendedGetPageRoute<T>(
      opaque: opaque ?? true,
      page: _resolvePage(page, 'to'),
      routeName: routeName,
      gestureWidth: gestureWidth,
      settings: RouteSettings(
        name: routeName,
        arguments: arguments,
      ),
      popGesture: popGesture ?? Get.defaultPopGesture,
      transition: transition ?? Get.defaultTransition,
      curve: curve ?? Get.defaultTransitionCurve,
      fullscreenDialog: fullscreenDialog,
      binding: binding,
      transitionDuration: duration ?? Get.defaultTransitionDuration,
    );
  }

  S put<S>(
    S dependency,
    {String? tag,
    bool permanent = false,
    InstanceBuilderCallback<S>? builder}
  ) {
    S result = GetInstance().put<S>(dependency, tag: tag, permanent: permanent);
    if (result is BaseGetxController) {
      BaseGetxControllerApplier applier = BaseGetxControllerApplier(baseGetxController: result);
      applier.tag = tag;
      applier.dispose();
    }
    return result;
  }
}

extension ExtendedLocalesIntl on _GetExtendedImpl {
  static final Map<String, Map<String, OnInitTextSpan>> _translationsWithTextSpan = {};
  Map<String, Map<String, OnInitTextSpan>> get translationsWithTextSpan => _translationsWithTextSpan;

  void addTranslationsWithTextSpan(Map<String, Map<String, OnInitTextSpan>> tr) {
    _translationsWithTextSpan.addAll(tr);
  }

  void clearTranslationsWithTextSpan() {
    _translationsWithTextSpan.clear();
  }

  void appendTranslationsWithTextSpan(Map<String, Map<String, OnInitTextSpan>> tr) {
    tr.forEach((key, map) {
      if (_translationsWithTextSpan.containsKey(key)) {
        _translationsWithTextSpan[key]!.addAll(map);
      } else {
        _translationsWithTextSpan[key] = map;
      }
    });
  }
}

extension TransWithTextSpan on String {
  bool get _fullLocaleAndKey {
    return GetExtended.translationsWithTextSpan.containsKey(
      "${Get.locale!.languageCode}_${Get.locale!.countryCode}"
    ) && GetExtended.translationsWithTextSpan[
      "${Get.locale!.languageCode}_${Get.locale!.countryCode}"
    ]!.containsKey(this);
  }

  Map<String, OnInitTextSpan>? get _getSimilarLanguageTranslation {
    final translationsWithNoCountry = GetExtended.translationsWithTextSpan
      .map((key, value) => MapEntry(key.split("_").first, value));
    final containsKey = translationsWithNoCountry
      .containsKey(Get.locale!.languageCode.split("_").first);
    if (!containsKey) {
      return null;
    }
    return translationsWithNoCountry[Get.locale!.languageCode.split("_").first];
  }

  TextSpan trTextSpan({TextSpan? defaultTextSpan, dynamic parameter}) {
    if (Get.locale?.languageCode == null) {
      return _effectiveDefaultTextSpan(defaultTextSpan, parameter);
    }
    if (_fullLocaleAndKey) {
      return GetExtended.translationsWithTextSpan["${Get.locale!.languageCode}_${Get.locale!.countryCode}"]![this]!(parameter);
    }
    final similarTranslation = _getSimilarLanguageTranslation;
    if (similarTranslation != null && similarTranslation.containsKey(this)) {
      return similarTranslation[this]!(parameter);
    } else if (Get.fallbackLocale != null) {
      final fallback = Get.fallbackLocale!;
      final key = "${fallback.languageCode}_${fallback.countryCode}";
      if (GetExtended.translationsWithTextSpan.containsKey(key) && GetExtended.translationsWithTextSpan[key]!.containsKey(this)) {
        return GetExtended.translationsWithTextSpan[key]![this]!(parameter);
      }
      if (GetExtended.translationsWithTextSpan.containsKey(fallback.languageCode) && GetExtended.translationsWithTextSpan[fallback.languageCode]!.containsKey(this)) {
        return GetExtended.translationsWithTextSpan[fallback.languageCode]![this]!(parameter);
      }
      return _effectiveDefaultTextSpan(defaultTextSpan, parameter);
    } else {
      return _effectiveDefaultTextSpan(defaultTextSpan, parameter);
    }
  }

  TextSpan _effectiveDefaultTextSpan(TextSpan? textSpan, dynamic parameter) {
    if (textSpan != null) {
      return textSpan;
    } else if (GetExtended.translationsWithTextSpan.containsKey("default")) {
      if (GetExtended.translationsWithTextSpan["default"]!.containsKey(this)) {
        return GetExtended.translationsWithTextSpan["default"]![this]!(parameter);
      } else {
        throw FlutterError("There is not containing desired sentence key.");
      }
    } else {
      throw FlutterError("textSpan parameter is null and there is not \"default\" key in translation, therefore make sure textSpan parameter is not null or \"default\" key in translation");
    }
  }
}

class GetPageBuilderWithPageName {
  String pageName;
  GetPageBuilder builder;

  GetPageBuilderWithPageName({
    required this.pageName,
    required this.builder
  });
}

// ignore: non_constant_identifier_names
final GetExtended = _GetExtendedImpl();