import 'package:flutter/material.dart';

import '../validation/validator/validator.dart';
import 'text_field_controller_state.dart';

class ObscurePasswordTextFieldControllerState extends TextFieldControllerState {
  bool obscurePassword;

  ObscurePasswordTextFieldControllerState({
    required TextEditingController textEditingController,
    required Validator validator,
    required this.obscurePassword
  }) : super(
    textEditingController: textEditingController,
    validator: validator
  );

  @override
  ObscurePasswordTextFieldControllerState copy({
    TextEditingController? textEditingController,
    Validator? validator,
    bool? obscurePassword
  }) {
    return ObscurePasswordTextFieldControllerState(
      textEditingController: textEditingController ?? this.textEditingController,
      validator: validator ?? this.validator,
      obscurePassword: obscurePassword ?? this.obscurePassword
    );
  }
}