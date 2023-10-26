import '../../validator/validator.dart';
import '../validator_group.dart';

class ThreeRatingGiveDeliveryReviewValidatorGroup extends ValidatorGroup {
  Validator unsatisfiedFeedbackValidator;

  ThreeRatingGiveDeliveryReviewValidatorGroup({
    required this.unsatisfiedFeedbackValidator
  }) {
    validatorList.add(unsatisfiedFeedbackValidator);
  }
}