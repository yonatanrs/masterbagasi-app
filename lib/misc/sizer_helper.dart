import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class _SizerHelperImpl {
  bool get _isPortraitOrIsWeb => SizerUtil.orientation == Orientation.portrait || kIsWeb;

  bool get isWidthLikeTablet => deviceWidthIgnoringOrientation >= 600;

  double get deviceWidthIgnoringOrientation {
    return _isPortraitOrIsWeb ? SizerUtil.width : SizerUtil.height;
  }

  double get deviceHeightIgnoringOrientation {
    return _isPortraitOrIsWeb ? SizerUtil.height : SizerUtil.width;
  }

  T checkingBasedWidthInput<T>(List<CheckingBasedWidthInputParameter<T>> checkingBasedWidthInputParameterList, T elseConditionResultValue) {
    int i = 0;
    while (i < checkingBasedWidthInputParameterList.length) {
      CheckingBasedWidthInputParameter<T> checkingBasedWidthInputParameter = checkingBasedWidthInputParameterList[i];
      bool result = checkingBasedWidthInputParameter.onCheckingWidthInput(deviceWidthIgnoringOrientation);
      if (result) {
        return checkingBasedWidthInputParameter.result;
      }
      i++;
    }
    return elseConditionResultValue;
  }
}

// ignore: non_constant_identifier_names
final SizerHelper = _SizerHelperImpl();

class CheckingBasedWidthInputParameter<T> {
  bool Function(double deviceWidthIgnoringOrientation) onCheckingWidthInput;
  T result;

  CheckingBasedWidthInputParameter({
    required this.onCheckingWidthInput,
    required this.result
  });
}