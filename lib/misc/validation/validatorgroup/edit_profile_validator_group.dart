import '../validator/validator.dart';
import 'validator_group.dart';

class EditProfileValidatorGroup extends ValidatorGroup {
  Validator nameValidator;
  Validator genderValidator;

  EditProfileValidatorGroup({
    required this.nameValidator,
    required this.genderValidator
  }) {
    validatorList.add(nameValidator);
    validatorList.add(genderValidator);
  }
}