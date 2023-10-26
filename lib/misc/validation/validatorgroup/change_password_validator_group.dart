import '../validator/validator.dart';
import 'validator_group.dart';

class ChangePasswordValidatorGroup extends ValidatorGroup {
  Validator currentPasswordValidator;
  Validator newPasswordValidator;
  Validator confirmNewPasswordValidator;

  ChangePasswordValidatorGroup({
    required this.currentPasswordValidator,
    required this.newPasswordValidator,
    required this.confirmNewPasswordValidator
  }) {
    validatorList.add(currentPasswordValidator);
    validatorList.add(newPasswordValidator);
    validatorList.add(confirmNewPasswordValidator);
  }
}