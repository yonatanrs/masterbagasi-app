import 'validator/validator.dart';

class ValidatorWrapper<T extends Validator> {
  T validator;

  ValidatorWrapper({
    required this.validator
  });

  ValidatorWrapper<T> copy({T? validator}) {
    return ValidatorWrapper<T>(
      validator: validator ?? this.validator
    );
  }
}