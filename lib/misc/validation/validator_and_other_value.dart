import 'validator/validator.dart';

class ValidatorAndOtherValue<T> extends Validator {
  final OnValidate _onValidate;

  T value;

  ValidatorAndOtherValue({
    required OnValidate onValidate,
    required this.value
  }): _onValidate = onValidate,
      super(onValidate: onValidate);

  ValidatorAndOtherValue<T> changeValue(T value) {
    this.value = value;
    return this;
  }
}