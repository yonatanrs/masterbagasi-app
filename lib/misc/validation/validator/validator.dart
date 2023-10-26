import 'package:flutter/material.dart';

import '../validation_result.dart';

typedef OnValidate = ValidationResult Function();

class Validator {
  final OnValidate? _onValidate;
  ValidationResult _validationResult = SuccessValidationResult();
  ValidationResult get validationResult => _validationResult;

  late final ValueNotifier<ValidationResult> validationNotifier;

  Validator({
    required OnValidate onValidate,
  }): _onValidate = onValidate {
    _initValidationNotifier();
  }

  Validator.nullableOnValidate({
    OnValidate? onValidate
  }): _onValidate = onValidate {
    _initValidationNotifier();
  }

  void _initValidationNotifier() {
    validationNotifier = ValueNotifier(_validationResult);
  }

  @protected
  ValidationResult validating() {
    return _onValidate != null ? _onValidate!() : throw FlutterError("onValidate private field cannot be null. Except if you want to override this method with ValidationResult non null return.");
  }

  ValidationResult validate() {
    _validationResult = validating();
    validationNotifier.value = _validationResult;
    return _validationResult;
  }
}