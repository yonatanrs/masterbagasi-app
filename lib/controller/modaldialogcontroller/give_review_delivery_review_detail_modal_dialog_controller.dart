import 'package:masterbagasi/misc/ext/load_data_result_ext.dart';

import '../../domain/entity/delivery/give_review_delivery_review_detail_parameter.dart';
import '../../domain/entity/delivery/give_review_delivery_review_detail_response.dart';
import '../../domain/entity/delivery/givedeliveryreviewvalue/give_delivery_review_value.dart';
import '../../domain/usecase/give_review_delivery_review_detail_use_case.dart';
import '../../misc/load_data_result.dart';
import '../../misc/typedef.dart';
import 'modal_dialog_controller.dart';

typedef _OnGetGiveDeliveryReviewValue = GiveDeliveryReviewValue Function();
typedef _OnGiveReviewDeliveryBack = void Function();
typedef _OnShowGiveReviewDeliveryRequestProcessLoadingCallback = Future<void> Function();
typedef _OnGiveReviewDeliveryRequestProcessSuccessCallback = Future<void> Function();
typedef _OnShowGiveReviewDeliveryRequestProcessFailedCallback = Future<void> Function(dynamic e);

class GiveReviewDeliveryReviewDetailModalDialogController extends ModalDialogController {
  final GiveReviewDeliveryReviewDetailUseCase giveReviewDeliveryReviewDetailUseCase;

  GiveReviewDeliveryReviewDetailModalDialogDelegate? _giveReviewDeliveryReviewDetailModalDialogDelegate;

  GiveReviewDeliveryReviewDetailModalDialogController(
    super.controllerManager,
    this.giveReviewDeliveryReviewDetailUseCase
  );

  void giveDeliveryReview() async {
    if (_giveReviewDeliveryReviewDetailModalDialogDelegate != null) {
      _giveReviewDeliveryReviewDetailModalDialogDelegate!.onUnfocusAllWidget();
      _giveReviewDeliveryReviewDetailModalDialogDelegate!.onShowGiveReviewDeliveryRequestProcessLoadingCallback();
      LoadDataResult<GiveReviewDeliveryReviewDetailResponse> giveReviewDeliveryReviewDetailResponseLoadDataResult = await giveReviewDeliveryReviewDetailUseCase.execute(
        GiveReviewDeliveryReviewDetailParameter(
          giveDeliveryReviewValue: _giveReviewDeliveryReviewDetailModalDialogDelegate!.onGetGiveDeliveryReviewValue()
        )
      ).future(
        parameter: apiRequestManager.addRequestToCancellationPart('login').value
      );
      _giveReviewDeliveryReviewDetailModalDialogDelegate!.onGiveReviewDeliveryBack();
      if (giveReviewDeliveryReviewDetailResponseLoadDataResult.isSuccess) {
        _giveReviewDeliveryReviewDetailModalDialogDelegate!.onGiveReviewDeliveryRequestProcessSuccessCallback();
      } else {
        _giveReviewDeliveryReviewDetailModalDialogDelegate!.onShowGiveReviewDeliveryRequestProcessFailedCallback(
          giveReviewDeliveryReviewDetailResponseLoadDataResult.resultIfFailed!
        );
      }
    }
  }

  GiveReviewDeliveryReviewDetailModalDialogController setGiveReviewDeliveryReviewDetailModalDialogDelegate(GiveReviewDeliveryReviewDetailModalDialogDelegate giveReviewDeliveryReviewDetailModalDialogDelegate) {
    _giveReviewDeliveryReviewDetailModalDialogDelegate = giveReviewDeliveryReviewDetailModalDialogDelegate;
    return this;
  }
}

class GiveReviewDeliveryReviewDetailModalDialogDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  _OnGiveReviewDeliveryBack onGiveReviewDeliveryBack;
  _OnGetGiveDeliveryReviewValue onGetGiveDeliveryReviewValue;
  _OnShowGiveReviewDeliveryRequestProcessLoadingCallback onShowGiveReviewDeliveryRequestProcessLoadingCallback;
  _OnGiveReviewDeliveryRequestProcessSuccessCallback onGiveReviewDeliveryRequestProcessSuccessCallback;
  _OnShowGiveReviewDeliveryRequestProcessFailedCallback onShowGiveReviewDeliveryRequestProcessFailedCallback;

  GiveReviewDeliveryReviewDetailModalDialogDelegate({
    required this.onUnfocusAllWidget,
    required this.onGiveReviewDeliveryBack,
    required this.onGetGiveDeliveryReviewValue,
    required this.onShowGiveReviewDeliveryRequestProcessLoadingCallback,
    required this.onGiveReviewDeliveryRequestProcessSuccessCallback,
    required this.onShowGiveReviewDeliveryRequestProcessFailedCallback
  });
}