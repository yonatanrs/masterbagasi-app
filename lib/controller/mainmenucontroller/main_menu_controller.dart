import 'package:get/get.dart';

import '../../misc/manager/controller_manager.dart';
import '../base_getx_controller.dart';

typedef _OnGetLoginStatus = bool Function();

class MainMenuController extends BaseGetxController {
  late Rx<bool> isLoginRx;

  MainMenuDelegate? _mainMenuDelegate;
  bool _hasCheckLoginStatus = false;

  MainMenuController(
    ControllerManager? controllerManager,
  ) : super(controllerManager) {
    isLoginRx = false.obs;
  }

  void checkLoginStatus({bool reset = false}) async {
    if (_mainMenuDelegate != null) {
      if (reset) {
        _hasCheckLoginStatus = false;
      }
      if (!_hasCheckLoginStatus) {
        _hasCheckLoginStatus = true;
        isLoginRx.value = _mainMenuDelegate!.onGetLoginStatus();
        updateMainMenuState();
      }
    }
  }

  MainMenuController setMainMenuDelegate(MainMenuDelegate mainMenuDelegate) {
    _mainMenuDelegate = mainMenuDelegate;
    return this;
  }

  void updateMainMenuState() {
    update();
  }
}

class MainMenuDelegate {
  _OnGetLoginStatus onGetLoginStatus;

  MainMenuDelegate({
    required this.onGetLoginStatus,
  });
}