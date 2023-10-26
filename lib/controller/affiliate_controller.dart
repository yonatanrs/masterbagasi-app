import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';
import 'package:masterbagasi/misc/ext/rx_ext.dart';

import '../domain/entity/user/getuser/get_user_parameter.dart';
import '../domain/entity/user/user.dart';
import '../domain/usecase/get_user_use_case.dart';
import '../misc/load_data_result.dart';
import 'base_getx_controller.dart';

class AffiliateController extends BaseGetxController {
  AffiliateDelegate? _affiliateDelegate;

  final GetUserUseCase getUserUseCase;
  LoadDataResult<User> _userLoadDataResult = NoLoadDataResult<User>();
  late Rx<LoadDataResultWrapper<User>> userLoadDataResultWrapperRx;
  bool _hasUserLoadDataResult = false;

  AffiliateController(
    super.controllerManager,
    this.getUserUseCase
  ) {
    userLoadDataResultWrapperRx = LoadDataResultWrapper<User>(_userLoadDataResult).obs;
  }

  AffiliateController setAffiliateDelegate(AffiliateDelegate affiliateDelegate) {
    _affiliateDelegate = affiliateDelegate;
    return this;
  }

  void loadLoggedUser() async {
    if (_hasUserLoadDataResult) {
      return;
    }
    _hasUserLoadDataResult = true;
    _userLoadDataResult = IsLoadingLoadDataResult<User>();
    _updateMenuMainMenuState();
    _userLoadDataResult = await getUserUseCase.execute(GetUserParameter()).future(
      parameter: apiRequestManager.addRequestToCancellationPart("user").value
    ).map<User>(
      (getUserResponse) => getUserResponse.user
    );
    if (_userLoadDataResult.isFailedBecauseCancellation) {
      return;
    }
    _updateMenuMainMenuState();
  }

  void _updateMenuMainMenuState() {
    userLoadDataResultWrapperRx.valueFromLast((value) => LoadDataResultWrapper<User>(_userLoadDataResult));
    update();
  }
}

class AffiliateDelegate {

}