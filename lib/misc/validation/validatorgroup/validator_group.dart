import 'package:flutter/material.dart';

import '../validation_result.dart';
import '../validator/validator.dart';

abstract class ValidatorGroup {
  @protected
  List<Validator> validatorList = <Validator>[];

  bool validate() {
    int failedCount = 0;
    for (var validator in validatorList) {
      if (validator.validate() is FailedValidationResult) {
        failedCount += 1;
      }
    }
    return failedCount == 0;
  }

  void dispose() {
    validatorList.clear();
  }
}