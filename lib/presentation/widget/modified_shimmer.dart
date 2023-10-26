import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../misc/constant.dart';
import 'shimmer_custom_effect_marker.dart';

// ignore: must_be_immutable
class ModifiedShimmer extends StatelessWidget {
  final Widget child;
  final Duration period;
  final ShimmerDirection direction;
  Gradient? _gradient;
  final int loop;
  final bool enabled;
  Color? _baseColor;
  Color? _highlightColor;

  ModifiedShimmer({
    Key? key,
    required this.child,
    required Gradient gradient,
    this.direction = ShimmerDirection.ltr,
    this.period = const Duration(milliseconds: 1500),
    this.loop = 0,
    this.enabled = true,
  }) : _gradient = gradient, super(key: key);

  ModifiedShimmer.fromColors({
    Key? key,
    required this.child,
    Color? baseColor,
    Color? highlightColor,
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
    this.loop = 0,
    this.enabled = true,
  }) : _baseColor = baseColor ?? Constant.colorBaseShimmer,
      _highlightColor = highlightColor ?? Constant.colorHighlightShimmer,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    _gradient ??= LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.centerRight,
      colors: <Color>[
        _baseColor!,
        _baseColor!,
        _highlightColor!,
        _baseColor!,
        _baseColor!
      ],
      stops: const <double>[
        0.0,
        0.35,
        0.5,
        0.65,
        1.0
      ]
    );
    return ShimmerCustomEffectMarker(
      child: Shimmer(
        key: key,
        child: child,
        gradient: _gradient!,
        direction: direction,
        period: period,
        loop: loop,
        enabled: enabled,
      )
    );
  }
}