import 'package:get/get_utils/get_utils.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../error/validation_error.dart';
import '../validation_result.dart';
import 'validator.dart';

typedef _EmailValidatorStringParameter = String Function();

class EmailValidator extends Validator {
  final OnValidate? _onValidateAfterValidateEmailFormat;
  // ignore: library_private_types_in_public_api
  final _EmailValidatorStringParameter email;

  EmailValidator({
    required this.email,
    OnValidate? onValidateAfterValidateEmailFormat
  }) : _onValidateAfterValidateEmailFormat = onValidateAfterValidateEmailFormat,
      super.nullableOnValidate(
        onValidate: null
      );

  @override
  ValidationResult validating() {
    String emailValue = email();
    if (emailValue.isEmptyString) {
      return FailedValidationResult(e: ValidationError(message: "${"Email is required".tr}."));
    } else if (!emailValue.isEmail) {
      return FailedValidationResult(e: ValidationError(message: "${"This input must be an email".tr}."));
    } else {
      if (_onValidateAfterValidateEmailFormat != null) {
        _onValidateAfterValidateEmailFormat!();
      }
      return SuccessValidationResult();
    }
  }
}