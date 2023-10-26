import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../misc/error/validation_error.dart';
import '../../../misc/typedef.dart';
import '../../../misc/validation/validation_result.dart';
import '../../../misc/validation/validator/validator.dart';
import '../../../misc/validation/validatorgroup/givedeliveryreviewvalidatorgroup/three_rating_give_delivery_review_validator_group.dart';
import '../../base_getx_controller.dart';

class ThreeRatingGiveDeliveryReviewContainerController extends BaseGetxController {
  late Rx<Validator> unsatisfiedFeedbackValidatorRx;
  late final ThreeRatingGiveDeliveryReviewValidatorGroup threeRatingGiveDeliveryReviewValidatorGroup;

  ThreeRatingGiveDeliveryReviewContainerDelegate? _threeRatingGiveDeliveryReviewContainerDelegate;

  ThreeRatingGiveDeliveryReviewContainerController(super.controllerManager) {
    threeRatingGiveDeliveryReviewValidatorGroup = ThreeRatingGiveDeliveryReviewValidatorGroup(
      unsatisfiedFeedbackValidator: Validator(
        onValidate: () => !_threeRatingGiveDeliveryReviewContainerDelegate!.onGetUnsatisfiedFeedbackInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Feedback is required".tr}."))
      ),
    );
    unsatisfiedFeedbackValidatorRx = threeRatingGiveDeliveryReviewValidatorGroup.unsatisfiedFeedbackValidator.obs;
  }

  void submit() {
    if (_threeRatingGiveDeliveryReviewContainerDelegate != null) {
      _threeRatingGiveDeliveryReviewContainerDelegate!.onUnfocusAllWidget();
      if (threeRatingGiveDeliveryReviewValidatorGroup.validate()) {
        _threeRatingGiveDeliveryReviewContainerDelegate!.onSubmit();
      }
    }
  }

  ThreeRatingGiveDeliveryReviewContainerController setThreeRatingGiveDeliveryReviewContainerDelegate(ThreeRatingGiveDeliveryReviewContainerDelegate threeRatingGiveDeliveryReviewContainerDelegate) {
    _threeRatingGiveDeliveryReviewContainerDelegate = threeRatingGiveDeliveryReviewContainerDelegate;
    return this;
  }
}

class ThreeRatingGiveDeliveryReviewContainerDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  String Function() onGetUnsatisfiedFeedbackInput;
  void Function() onSubmit;

  ThreeRatingGiveDeliveryReviewContainerDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetUnsatisfiedFeedbackInput,
    required this.onSubmit
  });
}