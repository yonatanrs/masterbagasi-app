import '../validator/validator.dart';
import 'validator_group.dart';

class TakeFriendCartValidatorGroup extends ValidatorGroup {
  Validator hostCartIdValidator;
  Validator hostCartPasswordValidator;

  TakeFriendCartValidatorGroup({
    required this.hostCartIdValidator,
    required this.hostCartPasswordValidator
  }) {
    validatorList.add(hostCartIdValidator);
    validatorList.add(hostCartPasswordValidator);
  }
}