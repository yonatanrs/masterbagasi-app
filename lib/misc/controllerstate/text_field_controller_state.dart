import 'package:flutter/cupertino.dart';

import '../validation/validator/validator.dart';

class TextFieldControllerState {
  TextEditingController textEditingController;
  Validator validator;

  TextFieldControllerState({
    required this.textEditingController,
    required this.validator
  });

  TextFieldControllerState copy({
    TextEditingController? textEditingController,
    Validator? validator
  }) {
    return TextFieldControllerState(
      textEditingController: textEditingController ?? this.textEditingController,
      validator: validator ?? this.validator
    );
  }
}