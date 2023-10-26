import '../../validator/validator.dart';
import '../validator_group.dart';

class FiveRatingGiveDeliveryReviewValidatorGroup extends ValidatorGroup {
  Validator verySatisfiedFeedbackValidator;

  FiveRatingGiveDeliveryReviewValidatorGroup({
    required this.verySatisfiedFeedbackValidator
  }) {
    validatorList.add(verySatisfiedFeedbackValidator);
  }
}