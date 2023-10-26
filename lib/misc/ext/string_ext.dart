import 'package:get/get_utils/get_utils.dart';

import '../constant.dart';
import '../multi_language_string.dart';

extension StringExt on String? {
  bool get isEmptyString => this == null ? true : (isBlank ?? false);
  bool get isNotEmptyString => !isEmptyString;
  String get toEmptyStringNonNull => !isEmptyString ? this! : "";
  String get toStringNonNull => !isEmptyString ? this! : Constant.textEmpty;
  String toStringNonNullWithCustomText({String? text}) => !isEmptyString ? this! : (!text.isEmptyString ? text! : Constant.textEmpty);
}

extension MultiLanguageStringExt on MultiLanguageString? {
  bool get isEmptyString => this == null ? true : toString().isEmptyString;
  bool get isNotEmptyString => !isEmptyString;
  String get toEmptyStringNonNull => !isEmptyString ? toString() : "";
  String get toStringNonNull => !isEmptyString ? toString() : Constant.textEmpty;
  String? get toStringNull => this == null ? null : toStringNonNull;
  String toStringNonNullWithCustomText({String? text}) => !isEmptyString ? toString() : (!text.isEmptyString ? text! : Constant.textEmpty);
}