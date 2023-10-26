import 'package:flutter/material.dart';

typedef OnBrightnessConditionChecking = Color Function(
  Brightness brightness,
  Color oldLightBrightnessConditionColor,
  Color oldDarkBrightnessConditionColor,
);

enum ContrastColorFormula {
  material, w3c
}

class _ColorHelperImpl {
  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Color contrastColorFromBackgroundColor(Color backgroundColor, {
    ContrastColorFormula contrastColorFormula = ContrastColorFormula.material,
    OnBrightnessConditionChecking? onBrightnessConditionChecking
  }) {
    late final Brightness brightness;
    if (contrastColorFormula == ContrastColorFormula.material) {
      brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    } else {
      if (backgroundColor.red * 0.299 + backgroundColor.green * 0.587 + backgroundColor.blue * 0.114 > 186.0) {
        brightness = Brightness.light;
      } else {
        brightness = Brightness.dark;
      }
    }

    OnBrightnessConditionChecking effectiveOnBrightnessConditionChecking = onBrightnessConditionChecking ?? (
      brightness, oldLightBrightnessConditionColor, oldDarkBrightnessConditionColor
    ) => brightness == Brightness.light ? oldLightBrightnessConditionColor : oldDarkBrightnessConditionColor;

    return effectiveOnBrightnessConditionChecking(
      brightness, Colors.black, Colors.white
    );
  }
}

// ignore: non_constant_identifier_names
var ColorHelper = _ColorHelperImpl();