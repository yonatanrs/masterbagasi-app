import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

typedef OnInitTextSpan = TextSpan Function(dynamic parameter);

abstract class ExtendedTranslation extends Translations {
  Map<String, Map<String, OnInitTextSpan>> get keysForTextSpan;
}