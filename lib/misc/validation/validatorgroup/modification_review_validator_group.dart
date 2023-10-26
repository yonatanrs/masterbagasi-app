import '../validator/validator.dart';
import 'validator_group.dart';

class ModificationReviewValidatorGroup extends ValidatorGroup {
  Validator reviewValidator;
  Validator ratingValidator;

  ModificationReviewValidatorGroup({
    required this.reviewValidator,
    required this.ratingValidator,
  }) {
    validatorList.addAll(<Validator>[reviewValidator, ratingValidator]);
  }
}