import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../misc/error/validation_error.dart';
import '../../../misc/typedef.dart';
import '../../../misc/validation/validation_result.dart';
import '../../../misc/validation/validator/validator.dart';
import '../../../misc/validation/validatorgroup/givedeliveryreviewvalidatorgroup/two_rating_give_delivery_review_validator_group.dart';
import '../../base_getx_controller.dart';

class TwoRatingGiveDeliveryReviewContainerController extends BaseGetxController {
  late Rx<Validator> dissatisfiedFeedbackValidatorRx;
  late final TwoRatingGiveDeliveryReviewValidatorGroup twoRatingGiveDeliveryReviewValidatorGroup;

  TwoRatingGiveDeliveryReviewContainerDelegate? _twoRatingGiveDeliveryReviewContainerDelegate;

  TwoRatingGiveDeliveryReviewContainerController(super.controllerManager) {
    twoRatingGiveDeliveryReviewValidatorGroup = TwoRatingGiveDeliveryReviewValidatorGroup(
      dissatisfiedFeedbackValidator: Validator(
        onValidate: () => !_twoRatingGiveDeliveryReviewContainerDelegate!.onGetDissatisfiedFeedbackInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Feedback is required".tr}."))
      ),
    );
    dissatisfiedFeedbackValidatorRx = twoRatingGiveDeliveryReviewValidatorGroup.dissatisfiedFeedbackValidator.obs;
  }

  void submit() {
    if (_twoRatingGiveDeliveryReviewContainerDelegate != null) {
      _twoRatingGiveDeliveryReviewContainerDelegate!.onUnfocusAllWidget();
      if (twoRatingGiveDeliveryReviewValidatorGroup.validate()) {
        _twoRatingGiveDeliveryReviewContainerDelegate!.onSubmit();
      }
    }
  }

  TwoRatingGiveDeliveryReviewContainerController setTwoRatingGiveDeliveryReviewContainerDelegate(TwoRatingGiveDeliveryReviewContainerDelegate twoRatingGiveDeliveryReviewContainerDelegate) {
    _twoRatingGiveDeliveryReviewContainerDelegate = twoRatingGiveDeliveryReviewContainerDelegate;
    return this;
  }
}

class TwoRatingGiveDeliveryReviewContainerDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  String Function() onGetDissatisfiedFeedbackInput;
  void Function() onSubmit;

  TwoRatingGiveDeliveryReviewContainerDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetDissatisfiedFeedbackInput,
    required this.onSubmit
  });
}