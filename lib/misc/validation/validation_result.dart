abstract class ValidationResult {}

class SuccessValidationResult extends ValidationResult {}

class FailedValidationResult extends ValidationResult {
  dynamic e;

  FailedValidationResult({required this.e});
}