import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../misc/error/validation_error.dart';
import '../../../misc/typedef.dart';
import '../../../misc/validation/validation_result.dart';
import '../../../misc/validation/validator/validator.dart';
import '../../../misc/validation/validatorgroup/givedeliveryreviewvalidatorgroup/one_rating_give_delivery_review_validator_group.dart';
import '../../base_getx_controller.dart';

class OneRatingGiveDeliveryReviewContainerController extends BaseGetxController {
  late Rx<Validator> disappointedFeedbackValidatorRx;
  late final OneRatingGiveDeliveryReviewValidatorGroup oneRatingGiveDeliveryReviewValidatorGroup;

  OneRatingGiveDeliveryReviewContainerDelegate? _oneRatingGiveDeliveryReviewContainerDelegate;

  OneRatingGiveDeliveryReviewContainerController(super.controllerManager) {
    oneRatingGiveDeliveryReviewValidatorGroup = OneRatingGiveDeliveryReviewValidatorGroup(
      disappointedFeedbackValidator: Validator(
        onValidate: () => !_oneRatingGiveDeliveryReviewContainerDelegate!.onGetDisappointedFeedbackInput().isEmptyString ? SuccessValidationResult() : FailedValidationResult(e: ValidationError(message: "${"Feedback is required".tr}."))
      ),
    );
    disappointedFeedbackValidatorRx = oneRatingGiveDeliveryReviewValidatorGroup.disappointedFeedbackValidator.obs;
  }

  void submit() {
    if (_oneRatingGiveDeliveryReviewContainerDelegate != null) {
      _oneRatingGiveDeliveryReviewContainerDelegate!.onUnfocusAllWidget();
      if (oneRatingGiveDeliveryReviewValidatorGroup.validate()) {
        _oneRatingGiveDeliveryReviewContainerDelegate!.onSubmit();
      }
    }
  }

  OneRatingGiveDeliveryReviewContainerController setOneRatingGiveDeliveryReviewContainerDelegate(OneRatingGiveDeliveryReviewContainerDelegate oneRatingGiveDeliveryReviewContainerDelegate) {
    _oneRatingGiveDeliveryReviewContainerDelegate = oneRatingGiveDeliveryReviewContainerDelegate;
    return this;
  }
}

class OneRatingGiveDeliveryReviewContainerDelegate {
  OnUnfocusAllWidget onUnfocusAllWidget;
  String Function() onGetDisappointedFeedbackInput;
  void Function() onSubmit;

  OneRatingGiveDeliveryReviewContainerDelegate({
    required this.onUnfocusAllWidget,
    required this.onGetDisappointedFeedbackInput,
    required this.onSubmit
  });
}