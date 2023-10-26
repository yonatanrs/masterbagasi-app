import '../validator/validator.dart';
import 'validator_group.dart';

class ForgotPasswordValidatorGroup extends ValidatorGroup {
  Validator emailValidator;

  ForgotPasswordValidatorGroup({
    required this.emailValidator,
  }) {
    validatorList.add(emailValidator);
  }
}