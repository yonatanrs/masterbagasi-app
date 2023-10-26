import '../validator/validator.dart';
import 'validator_group.dart';

class AddressValidatorGroup extends ValidatorGroup {
  Validator nameValidator;
  Validator emailValidator;
  Validator labelValidator;
  Validator addressValidator;
  Validator phoneNumberValidator;
  Validator zipCodeValidator;
  Validator countryValidator;
  Validator cityValidator;
  Validator stateValidator;

  AddressValidatorGroup({
    required this.nameValidator,
    required this.emailValidator,
    required this.labelValidator,
    required this.addressValidator,
    required this.phoneNumberValidator,
    required this.zipCodeValidator,
    required this.countryValidator,
    required this.cityValidator,
    required this.stateValidator
  }) {
    validatorList.add(nameValidator);
    validatorList.add(emailValidator);
    validatorList.add(labelValidator);
    validatorList.add(addressValidator);
    validatorList.add(phoneNumberValidator);
    validatorList.add(zipCodeValidator);
    validatorList.add(countryValidator);
    validatorList.add(cityValidator);
    validatorList.add(stateValidator);
  }
}