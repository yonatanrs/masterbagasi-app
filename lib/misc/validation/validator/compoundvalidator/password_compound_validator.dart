import '../validator.dart';
import 'compound_validator.dart';

class PasswordCompoundValidator extends CompoundValidator {
  Validator passwordValidator;
  Validator passwordConfirmationValidator;

  PasswordCompoundValidator({
    required this.passwordValidator,
    required this.passwordConfirmationValidator
  }) : super(validatorList: []) {
    validatorList.add(passwordValidator);
    validatorList.add(passwordConfirmationValidator);
  }
}