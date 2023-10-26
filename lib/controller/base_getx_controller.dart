import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../misc/manager/api_request_manager.dart';
import '../misc/manager/controller_manager.dart';

abstract class BaseGetxController extends GetxController {
  @protected
  late ApiRequestManager apiRequestManager;
  @protected
  late ControllerManager? controllerManager;

  bool _initLater = false;
  int _initCount = 0;
  String? _tag;
  String? get tag => _tag;

  BaseGetxController(this.controllerManager, {bool initLater = false}): super() {
    apiRequestManager = ApiRequestManager();
    _initLater = initLater;
  }

  @override
  void onInit() {
    super.onInit();
    if (!_initLater) {
      initController();
    }
    _initLater = false;
  }

  void initController() {
    onInitController();
    _initCount += 1;
  }

  void onInitController() {}

  bool hasInitController() {
    return _initCount > 0;
  }

  @override
  void onClose() {
    super.onClose();
    controllerManager = null;
    apiRequestManager.cancelAllRequest();
  }
}

class BaseGetxControllerApplier {
  BaseGetxController? baseGetxController;

  BaseGetxControllerApplier({
    required this.baseGetxController
  });

  set tag(String? value) {
    baseGetxController?._tag = value;
  }

  void dispose() {
    baseGetxController = null;
  }
}