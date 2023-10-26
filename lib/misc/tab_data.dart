import 'package:flutter/material.dart';

class TabData {
  final String? text;
  final WidgetBuilder? icon;
  final EdgeInsetsGeometry iconMargin;
  final double? height;
  final WidgetBuilder? child;

  TabData({
    this.text,
    this.icon,
    this.iconMargin = const EdgeInsets.only(bottom: 10.0),
    this.height,
    this.child,
  });
}