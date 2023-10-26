import '../validator/compoundvalidator/password_compound_validator.dart';
import '../validator/validator.dart';
import 'validator_group.dart';

class RegisterValidatorGroup extends ValidatorGroup {
  Validator emailValidator;
  Validator nameValidator;
  PasswordCompoundValidator passwordCompoundValidator;

  RegisterValidatorGroup({
    required this.emailValidator,
    required this.nameValidator,
    required this.passwordCompoundValidator
  }) {
    validatorList.add(emailValidator);
    validatorList.add(nameValidator);
    validatorList.add(passwordCompoundValidator);
  }
}