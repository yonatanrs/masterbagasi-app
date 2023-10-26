import 'package:flutter/material.dart';

class ModifiedVerticalDivider extends StatelessWidget {
  final Color? lineColor;
  final double lineWidth;
  final double? lineHeight;
  final BorderRadius borderRadius;

  const ModifiedVerticalDivider({
    super.key,
    this.lineColor,
    this.lineWidth = 1.5,
    this.lineHeight,
    this.borderRadius = const BorderRadius.all(Radius.zero)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: lineWidth,
      height: lineHeight,
      decoration: BoxDecoration(
        color: lineColor,
        borderRadius: borderRadius
      ),
    );
  }
}