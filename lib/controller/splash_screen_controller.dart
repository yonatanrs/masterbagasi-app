import 'package:flutter/material.dart';

import '../misc/login_helper.dart';
import '../misc/manager/controller_manager.dart';
import 'base_getx_controller.dart';

class SplashScreenController extends BaseGetxController {
  bool _isStartNextPage = false;

  SplashScreenController(ControllerManager? controllerManager) : super(controllerManager);

  void startIntroductionPage({
    required VoidCallback onStartHomePage
  }) async {
    if (_isStartNextPage) {
      return;
    }
    _isStartNextPage = true;
    await Future.delayed(const Duration(seconds: 3));
    onStartHomePage();
  }
}