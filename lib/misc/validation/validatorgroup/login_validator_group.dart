import '../validator/validator.dart';
import 'validator_group.dart';

class LoginValidatorGroup extends ValidatorGroup {
  Validator emailValidator;
  Validator passwordValidator;

  LoginValidatorGroup({
    required this.emailValidator,
    required this.passwordValidator
  }) {
    validatorList.add(emailValidator);
    validatorList.add(passwordValidator);
  }
}