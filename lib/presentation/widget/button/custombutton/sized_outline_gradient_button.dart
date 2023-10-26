import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../../misc/constant.dart';
import '../../../../misc/error/message_error.dart';
import 'outline_gradient_button.dart';

enum OutlineGradientButtonType {
  solid, outline
}

enum OutlineGradientButtonVariation {
  variation1, variation2, variation3
}

class SizedOutlineGradientButton extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final Widget? child;
  final Widget Function(TextStyle?)? childInterceptor;
  final String? text;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final FocusNode? focusNode;
  final bool autofocus;
  final OutlineGradientButtonType outlineGradientButtonType;
  final OutlineGradientButtonVariation outlineGradientButtonVariation;
  final _GradientButtonVariation Function(OutlineGradientButtonType)? customGradientButtonVariation;
  final EdgeInsets? customPadding;

  const SizedOutlineGradientButton({
    Key? key,
    this.width,
    this.height,
    required this.onPressed,
    this.child,
    this.childInterceptor,
    required this.text,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.outlineGradientButtonType = OutlineGradientButtonType.solid,
    this.outlineGradientButtonVariation = OutlineGradientButtonVariation.variation1,
    this.customGradientButtonVariation,
    this.customPadding
  }) : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    _GradientButtonVariation gradientButtonVariation = customGradientButtonVariation != null ? customGradientButtonVariation!(outlineGradientButtonType) : _getGradientButtonVariation();
    if (gradientButtonVariation is CustomGradientButtonVariation) {
      gradientButtonVariation._defaultGradientButtonVariation = _getGradientButtonVariation();
    }
    TextStyle disabledTextStyle = const TextStyle(
      color: Colors.grey
    );
    Color disabledBackgroundColor = Colors.grey.shade300;
    Gradient disabledGradient = SweepGradient(
      stops: const [1],
      colors: [disabledBackgroundColor],
    );
    TextStyle? textStyle = onPressed != null ? gradientButtonVariation.textStyle : disabledTextStyle;
    return SizedBox(
      width: width,
      height: height,
      child: OutlineGradientButton(
        onTap: onPressed,
        gradient: onPressed != null ? gradientButtonVariation.gradient : disabledGradient,
        strokeWidth: 1.5,
        backgroundColor: onPressed != null ? gradientButtonVariation.backgroundColor : disabledBackgroundColor,
        padding: customPadding != null ? customPadding! : const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
        radius: const Radius.circular(8),
        inkWell: true,
        onLongPress: onLongPress,
        onHover: onHover,
        onFocusChange: onFocusChange,
        focusNode: focusNode,
        autofocus: autofocus,
        child: childInterceptor != null ? childInterceptor!(textStyle) : (
          child != null ? child! : Center(
            child: Text(
              text.toEmptyStringNonNull,
              style: textStyle,
            )
          )
        )
      )
    );
  }

  _GradientButtonVariation _getGradientButtonVariation() {
    if (outlineGradientButtonVariation == OutlineGradientButtonVariation.variation1) {
      return _Variation1GradientButtonVariation(outlineGradientButtonType: outlineGradientButtonType);
    } else if (outlineGradientButtonVariation == OutlineGradientButtonVariation.variation2) {
      return _Variation2GradientButtonVariation(outlineGradientButtonType: outlineGradientButtonType);
    } else if (outlineGradientButtonVariation == OutlineGradientButtonVariation.variation3) {
      return _Variation3GradientButtonVariation(outlineGradientButtonType: outlineGradientButtonType);
    } else {
      throw MessageError(title: "Outline gradient button is not suitable");
    }
  }
}

abstract class _GradientButtonVariation {
  OutlineGradientButtonType outlineGradientButtonType;
  Gradient get gradient;
  Color get backgroundColor;
  TextStyle? get textStyle;

  _GradientButtonVariation({
    required this.outlineGradientButtonType
  });
}

class _Variation1GradientButtonVariation extends _GradientButtonVariation {
  _Variation1GradientButtonVariation({required super.outlineGradientButtonType});

  @override
  Color get backgroundColor => outlineGradientButtonType == OutlineGradientButtonType.solid ? Constant.colorDarkBlue : Colors.transparent;

  @override
  Gradient get gradient => Constant.buttonGradient;

  @override
  TextStyle? get textStyle => TextStyle(
    color: outlineGradientButtonType == OutlineGradientButtonType.solid ? Colors.white : null,
    fontWeight: FontWeight.bold
  );
}

class _Variation2GradientButtonVariation extends _GradientButtonVariation {
  _Variation2GradientButtonVariation({required super.outlineGradientButtonType});

  @override
  Color get backgroundColor => outlineGradientButtonType == OutlineGradientButtonType.solid ? Constant.colorMain : Colors.transparent;

  @override
  Gradient get gradient => SweepGradient(
    stops: const [1],
    colors: [Constant.colorMain],
  );

  @override
  TextStyle? get textStyle => TextStyle(
    color: outlineGradientButtonType == OutlineGradientButtonType.solid ? Colors.white : Constant.colorMain,
  );
}

class _Variation3GradientButtonVariation extends _GradientButtonVariation {
  _Variation3GradientButtonVariation({required super.outlineGradientButtonType});

  @override
  Color get backgroundColor => outlineGradientButtonType == OutlineGradientButtonType.solid ? Colors.black : Colors.transparent;

  @override
  Gradient get gradient => const SweepGradient(
    stops: [1],
    colors: [Colors.black],
  );

  @override
  TextStyle? get textStyle => TextStyle(
    color: outlineGradientButtonType == OutlineGradientButtonType.solid ? Colors.white : Colors.black,
    fontWeight: FontWeight.bold
  );
}

class CustomGradientButtonVariation extends _GradientButtonVariation {
  final Color? _backgroundColor;
  final Gradient? _gradient;
  final TextStyle? _textStyle;
  final bool _showDefaultGradientButtonVariationIfNotConfigured;
  late _GradientButtonVariation _defaultGradientButtonVariation;

  CustomGradientButtonVariation({
    required super.outlineGradientButtonType,
    Color? backgroundColor,
    Gradient? gradient,
    TextStyle? textStyle,
    bool showDefaultGradientButtonVariationIfNotConfigured = false
  }) : _backgroundColor = backgroundColor,
      _gradient = gradient,
      _textStyle = textStyle,
      _showDefaultGradientButtonVariationIfNotConfigured = showDefaultGradientButtonVariationIfNotConfigured;

  @override
  Color get backgroundColor {
    if (_backgroundColor != null) {
      return _backgroundColor!;
    } else {
      if (_showDefaultGradientButtonVariationIfNotConfigured) {
        return _defaultGradientButtonVariation.backgroundColor;
      } else {
        return outlineGradientButtonType == OutlineGradientButtonType.solid ? Constant.colorMain : Colors.transparent;
      }
    }
  }

  @override
  Gradient get gradient {
    if (_gradient != null) {
      return _gradient!;
    } else {
      if (_showDefaultGradientButtonVariationIfNotConfigured) {
        return _defaultGradientButtonVariation.gradient;
      } else {
        return Constant.buttonGradient;
      }
    }
  }

  @override
  TextStyle? get textStyle {
    if (_textStyle != null) {
      return _textStyle!;
    } else {
      if (_showDefaultGradientButtonVariationIfNotConfigured) {
        return _defaultGradientButtonVariation.textStyle;
      } else {
        return TextStyle(
          color: outlineGradientButtonType == OutlineGradientButtonType.solid ? Colors.white : null,
          fontWeight: FontWeight.bold
        );
      }
    }
  }
}