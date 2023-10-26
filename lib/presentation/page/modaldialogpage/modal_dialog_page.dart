import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/controller/modaldialogcontroller/modal_dialog_controller.dart';

import '../../../misc/manager/controller_manager.dart';
import '../getx_page.dart';

abstract class ModalDialogPage<T extends ModalDialogController> extends DefaultGetxPage {
  late final ControllerMember<T> modalDialogController = ControllerMember<T>().addToControllerManager(controllerManager);

  T onCreateModalDialogController();

  ModalDialogPage({Key? key}) : super(key: key, systemUiOverlayStyle: SystemUiOverlayStyle.dark);

  @override
  void onSetController() {
    modalDialogController.controller = Get.put<T>(onCreateModalDialogController());
  }
}