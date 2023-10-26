import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/manager/controller_manager.dart';
import 'package:masterbagasi/misc/pageviewchildrenbuilder/introduction_page_view_children_builder.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../misc/controllerstate/page_view_controller_state.dart';
import '../misc/has_visited_introduction_page_helper.dart';
import 'base_getx_controller.dart';

class IntroductionController extends BaseGetxController {
  final IntroductionPageViewChildrenBuilder _introductionPageViewChildrenBuilder = IntroductionPageViewChildrenBuilder();
  final PreloadPageController _preloadPageController = PreloadPageController();
  late final Rx<PageViewControllerState> introductionPageController;

  IntroductionController(ControllerManager? controllerManager) : super(controllerManager) {
    introductionPageController = PageViewControllerState(
      preloadPageController: _preloadPageController,
      pageViewChildrenBuilder: _introductionPageViewChildrenBuilder
    ).obs;
  }

  @override
  void onInitController() {
    HasVisitedIntroductionPageHelper.saveHasVisitedIntroductionPage(true).future();
  }

  @override
  void onClose() {
    super.onClose();
    _preloadPageController.dispose();
    _introductionPageViewChildrenBuilder.dispose();
  }
}