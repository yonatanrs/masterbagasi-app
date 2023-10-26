import 'package:masterbagasi/misc/ext/validation_result_ext.dart';

import '../../validation_result.dart';
import '../validator.dart';

abstract class CompoundValidator extends Validator {
  final List<Validator> validatorList;

  CompoundValidator({
    required this.validatorList,
  }) : super.nullableOnValidate(onValidate: null);

  @override
  ValidationResult validating() {
    for (var validator in validatorList) {
      ValidationResult validationResult = validator.validate();
      if (validationResult.isFailed) {
        return validationResult;
      }
    }
    return SuccessValidationResult();
  }
}