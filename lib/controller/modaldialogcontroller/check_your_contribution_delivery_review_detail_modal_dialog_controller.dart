import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/future_ext.dart';
import 'package:masterbagasi/misc/ext/rx_ext.dart';

import '../../domain/entity/delivery/check_your_contribution_delivery_review_detail_parameter.dart';
import '../../domain/entity/delivery/check_your_contribution_delivery_review_detail_response.dart';
import '../../domain/entity/user/getuser/get_user_parameter.dart';
import '../../domain/entity/user/user.dart';
import '../../domain/usecase/get_check_your_contribution_delivery_review_detail_use_case.dart';
import '../../domain/usecase/get_user_use_case.dart';
import '../../misc/load_data_result.dart';
import 'modal_dialog_controller.dart';

class CheckYourContributionDeliveryReviewDetailModalDialogController extends ModalDialogController {
  final GetUserUseCase getUserUseCase;
  final GetCheckYourContributionDeliveryReviewDetailUseCase getCheckYourContributionDeliveryReviewDetailUseCase;

  LoadDataResult<User> _userLoadDataResult = NoLoadDataResult<User>();
  late Rx<LoadDataResultWrapper<User>> userLoadDataResultWrapperRx;
  bool _hasInitUser = false;

  LoadDataResult<CheckYourContributionDeliveryReviewDetailResponse> _checkYourContributionDeliveryReviewDetailResponseLoadDataResult = NoLoadDataResult<CheckYourContributionDeliveryReviewDetailResponse>();
  late Rx<LoadDataResultWrapper<CheckYourContributionDeliveryReviewDetailResponse>> checkYourContributionDeliveryReviewDetailResponseLoadDataResultWrapperRx;
  bool _hasInitCheckYourContributionDeliveryReviewDetailResponse = false;

  bool _hasInitAll = false;

  CheckYourContributionDeliveryReviewDetailModalDialogController(
    super.controllerManager,
    this.getUserUseCase,
    this.getCheckYourContributionDeliveryReviewDetailUseCase
  ) {
    userLoadDataResultWrapperRx = LoadDataResultWrapper<User>(_userLoadDataResult).obs;
    checkYourContributionDeliveryReviewDetailResponseLoadDataResultWrapperRx = LoadDataResultWrapper<CheckYourContributionDeliveryReviewDetailResponse>(_checkYourContributionDeliveryReviewDetailResponseLoadDataResult).obs;
  }

  void initAll() {
    if (_hasInitAll) {
      return;
    }
    _hasInitAll = true;
    initUser();
    initCheckYourContributionDeliveryReviewDetailResponse();
  }

  void initUser() async {
    if (_hasInitUser) {
      return;
    }
    _hasInitUser = true;
    _userLoadDataResult = IsLoadingLoadDataResult<User>();
    _updateCheckYourContributionDeliveryReviewDetailState();
    _userLoadDataResult = await getUserUseCase.execute(
      GetUserParameter()
    ).future(
      parameter: apiRequestManager.addRequestToCancellationPart("logged-user-profile").value
    ).map<User>(
      (getUserResponse) => getUserResponse.user
    );
    _updateCheckYourContributionDeliveryReviewDetailState();
  }

  void initCheckYourContributionDeliveryReviewDetailResponse() async {
    if (_hasInitCheckYourContributionDeliveryReviewDetailResponse) {
      return;
    }
    _hasInitCheckYourContributionDeliveryReviewDetailResponse = true;
    _checkYourContributionDeliveryReviewDetailResponseLoadDataResult = IsLoadingLoadDataResult<CheckYourContributionDeliveryReviewDetailResponse>();
    _updateCheckYourContributionDeliveryReviewDetailState();
    _checkYourContributionDeliveryReviewDetailResponseLoadDataResult = await getCheckYourContributionDeliveryReviewDetailUseCase.execute(
      CheckYourContributionDeliveryReviewDetailParameter()
    ).future(
      parameter: apiRequestManager.addRequestToCancellationPart("check-your-contribution-delivery-review-detail").value
    );
    _updateCheckYourContributionDeliveryReviewDetailState();
  }

  void _updateCheckYourContributionDeliveryReviewDetailState() {
    userLoadDataResultWrapperRx.valueFromLast(
      (value) => LoadDataResultWrapper<User>(_userLoadDataResult)
    );
    checkYourContributionDeliveryReviewDetailResponseLoadDataResultWrapperRx.valueFromLast(
      (value) => LoadDataResultWrapper<CheckYourContributionDeliveryReviewDetailResponse>(_checkYourContributionDeliveryReviewDetailResponseLoadDataResult)
    );
    update();
  }
}