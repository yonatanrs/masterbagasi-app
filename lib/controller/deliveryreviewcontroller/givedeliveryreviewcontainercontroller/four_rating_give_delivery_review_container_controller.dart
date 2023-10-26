import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../misc/error/validation_error.dart';
import '../../../misc/typedef.dart';
import '../../../misc/validation/validation_result.dart';
import '../../../misc/validation/validator/validator.dart';
import '../../../misc/validation/validatorgroup/givedeliveryreviewvalidatorgroup/four_rating_give_delivery_review_validator_group.dart';
import '../../base_getx_controller.dart';

class FourRatingGiveDeliveryReviewContainerController extends BaseGetxController {
  late Rx<Validator> satisfiedFeedbackValidatorRx;
  late final FourRatingGiveDeliveryReviewValidatorGroup fourRatingGiveDeliveryReviewValidatorGroup;

  FourRatingGiveDeliveryReviewContainerDelegate? _fourRatingGiveDeliveryReviewContainerDelegate;

  FourRatingGiveDeliveryReviewContainerController(super.controllerManager) {
    fourRatingGiveDeliveryReviewValidatorGroup = FourRatingGiveDeliveryReviewValidatorGroup(
      satisfiedFeedbackValidator: Validator(
        onValidate: () => !_fourRatingGiveDeliveryReviewContainerDelegate!.onGetSatisfiedFeedbackInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Feedback is required".tr}."))
      ),
    );
    satisfiedFeedbackValidatorRx = fourRatingGiveDeliveryReviewValidatorGroup.satisfiedFeedbackValidator.obs;
  }

  void submit() {
    if (_fourRatingGiveDeliveryReviewContainerDelegate != null) {
      _fourRatingGiveDeliveryReviewContainerDelegate!.onUnfocusAllWidget();
      if (fourRatingGiveDeliveryReviewValidatorGroup.validate()) {
        _fourRatingGiveDeliveryReviewContainerDelegate!.onSubmit();
      }
    }
  }

  FourRatingGiveDeliveryReviewContainerController setFourRatingGiveDeliveryReviewContainerDelegate(FourRatingGiveDeliveryReviewContainerDelegate fourRatingGiveDeliveryReviewContainerDelegate) {
    _fourRatingGiveDeliveryReviewContainerDelegate = fourRatingGiveDeliveryReviewContainerDelegate;
    return this;
  }
}

class FourRatingGiveDeliveryReviewContainerDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  String Function() onGetSatisfiedFeedbackInput;
  void Function() onSubmit;

  FourRatingGiveDeliveryReviewContainerDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetSatisfiedFeedbackInput,
    required this.onSubmit
  });
}