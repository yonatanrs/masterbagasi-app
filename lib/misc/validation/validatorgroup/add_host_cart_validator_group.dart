import '../validator/validator.dart';
import 'validator_group.dart';

class AddHostCartValidatorGroup extends ValidatorGroup {
  Validator hostCartIdValidator;
  Validator hostCartPasswordValidator;

  AddHostCartValidatorGroup({
    required this.hostCartIdValidator,
    required this.hostCartPasswordValidator
  }) {
    validatorList.add(hostCartIdValidator);
    validatorList.add(hostCartPasswordValidator);
  }
}