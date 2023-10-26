import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// ignore: implementation_imports
import 'package:smooth_page_indicator/src/effects/indicator_effect.dart';

class PreloadPageControllerSmoothPageIndicator extends AnimatedWidget {
  final PreloadPageController controller;
  final IndicatorEffect effect;
  final Axis axisDirection;
  final int count;
  final TextDirection? textDirection;
  final OnDotClicked? onDotClicked;

  const PreloadPageControllerSmoothPageIndicator({
    Key? key,
    required this.controller,
    required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
  }) : super(key: key, listenable: controller);

  @override
  Widget build(BuildContext context) {
    return SmoothIndicator(
      offset: _offset,
      count: count,
      effect: effect,
      textDirection: textDirection,
      axisDirection: axisDirection,
      onDotClicked: onDotClicked,
    );
  }

  double get _offset {
    try {
      var offset = controller.page ?? controller.initialPage.toDouble();
      return offset % count;
    } catch (_) {
      return controller.initialPage.toDouble();
    }
  }
}