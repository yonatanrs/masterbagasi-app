import '../../validator/validator.dart';
import '../validator_group.dart';

class OneRatingGiveDeliveryReviewValidatorGroup extends ValidatorGroup {
  Validator disappointedFeedbackValidator;

  OneRatingGiveDeliveryReviewValidatorGroup({
    required this.disappointedFeedbackValidator
  }) {
    validatorList.add(disappointedFeedbackValidator);
  }
}