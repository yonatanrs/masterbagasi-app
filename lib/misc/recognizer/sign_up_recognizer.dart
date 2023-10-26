import 'package:flutter/gestures.dart';

class SignUpRecognizer {
  TapGestureRecognizer termAndConditionsTapGestureRecognizer;
  TapGestureRecognizer privacyPolicyTapGestureRecognizer;

  SignUpRecognizer({
    required this.termAndConditionsTapGestureRecognizer,
    required this.privacyPolicyTapGestureRecognizer
  });
}