import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../misc/error/validation_error.dart';
import '../../../misc/typedef.dart';
import '../../../misc/validation/validation_result.dart';
import '../../../misc/validation/validator/validator.dart';
import '../../../misc/validation/validatorgroup/givedeliveryreviewvalidatorgroup/five_rating_give_delivery_review_validator_group.dart';
import '../../base_getx_controller.dart';

class FiveRatingGiveDeliveryReviewContainerController extends BaseGetxController {
  late Rx<Validator> verySatisfiedFeedbackValidatorRx;
  late final FiveRatingGiveDeliveryReviewValidatorGroup fiveRatingGiveDeliveryReviewValidatorGroup;

  FiveRatingGiveDeliveryReviewContainerDelegate? _fiveRatingGiveDeliveryReviewContainerDelegate;

  FiveRatingGiveDeliveryReviewContainerController(super.controllerManager) {
    fiveRatingGiveDeliveryReviewValidatorGroup = FiveRatingGiveDeliveryReviewValidatorGroup(
      verySatisfiedFeedbackValidator: Validator(
        onValidate: () => !_fiveRatingGiveDeliveryReviewContainerDelegate!.onGetVerySatisfiedFeedbackInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Feedback is required".tr}."))
      ),
    );
    verySatisfiedFeedbackValidatorRx = fiveRatingGiveDeliveryReviewValidatorGroup.verySatisfiedFeedbackValidator.obs;
  }

  void submit() {
    if (_fiveRatingGiveDeliveryReviewContainerDelegate != null) {
      _fiveRatingGiveDeliveryReviewContainerDelegate!.onUnfocusAllWidget();
      if (fiveRatingGiveDeliveryReviewValidatorGroup.validate()) {
        _fiveRatingGiveDeliveryReviewContainerDelegate!.onSubmit();
      }
    }
  }

  FiveRatingGiveDeliveryReviewContainerController setFiveRatingGiveDeliveryReviewContainerDelegate(FiveRatingGiveDeliveryReviewContainerDelegate fiveRatingGiveDeliveryReviewContainerDelegate) {
    _fiveRatingGiveDeliveryReviewContainerDelegate = fiveRatingGiveDeliveryReviewContainerDelegate;
    return this;
  }
}

class FiveRatingGiveDeliveryReviewContainerDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  String Function() onGetVerySatisfiedFeedbackInput;
  void Function() onSubmit;

  FiveRatingGiveDeliveryReviewContainerDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetVerySatisfiedFeedbackInput,
    required this.onSubmit
  });
}