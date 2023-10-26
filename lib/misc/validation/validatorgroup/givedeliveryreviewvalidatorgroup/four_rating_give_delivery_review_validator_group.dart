import '../../validator/validator.dart';
import '../validator_group.dart';

class FourRatingGiveDeliveryReviewValidatorGroup extends ValidatorGroup {
  Validator satisfiedFeedbackValidator;

  FourRatingGiveDeliveryReviewValidatorGroup({
    required this.satisfiedFeedbackValidator
  }) {
    validatorList.add(satisfiedFeedbackValidator);
  }
}