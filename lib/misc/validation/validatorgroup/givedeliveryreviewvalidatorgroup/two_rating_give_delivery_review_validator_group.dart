import '../../validator/validator.dart';
import '../validator_group.dart';

class TwoRatingGiveDeliveryReviewValidatorGroup extends ValidatorGroup {
  Validator dissatisfiedFeedbackValidator;

  TwoRatingGiveDeliveryReviewValidatorGroup({
    required this.dissatisfiedFeedbackValidator
  }) {
    validatorList.add(dissatisfiedFeedbackValidator);
  }
}