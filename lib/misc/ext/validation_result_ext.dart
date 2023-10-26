import 'package:masterbagasi/misc/validation/validation_result.dart';

extension ValidationResultExt<T> on ValidationResult {
  bool get isSuccess => this is SuccessValidationResult;
  bool get isFailed => this is FailedValidationResult;
  dynamic get resultIfFailed => isFailed ? (this as FailedValidationResult).e : null;
}