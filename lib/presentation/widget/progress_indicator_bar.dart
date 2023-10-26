import 'package:flutter/material.dart';

class ProgressIndicatorBar extends LeafRenderObjectWidget {
  final double height;
  final double barValue;
  final Color barColor;
  final Color barBackgroundColor;
  final Radius? barRadius;
  final Radius? barBackgroundRadius;

  const ProgressIndicatorBar({
    Key? key,
    required this.height,
    this.barValue = 0.5,
    required this.barColor,
    required this.barBackgroundColor,
    this.barRadius,
    this.barBackgroundRadius
  }) : super(key: key);

  @override
  _ProgressIndicatorBarRenderer createRenderObject(BuildContext context) {
    return _ProgressIndicatorBarRenderer(
      barValue: barValue,
      barColor: barColor,
      barBackgroundColor: barBackgroundColor,
      height: height,
      barRadius: barRadius,
      barBackgroundRadius: barBackgroundRadius
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant _ProgressIndicatorBarRenderer renderObject) {
    renderObject
      ..barValue = barValue
      ..barColor = barColor
      ..barBackgroundColor = barBackgroundColor
      ..height = height;
  }
}

class _ProgressIndicatorBarRenderer extends RenderBox {
  double _barValue;
  set barValue(double value) {
    _barValue = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  Color _barColor;
  set barColor(Color value) {
    _barColor = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  Color _barBackgroundColor;
  set barBackgroundColor(Color value) {
    _barBackgroundColor = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  double _height;
  set height(double value) {
    _height = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  Radius? _barRadius;
  set barRadius(Radius? value) {
    _barRadius = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  Radius? _barBackgroundRadius;
  set barBackgroundRadius(Radius? value) {
    _barBackgroundRadius = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  _ProgressIndicatorBarRenderer({
    required double barValue,
    required Color barColor,
    required Color barBackgroundColor,
    required double height,
    required Radius? barRadius,
    required Radius? barBackgroundRadius,
  }) : _barValue = barValue,
        _barColor = barColor,
        _barBackgroundColor = barBackgroundColor,
        _height = height,
        _barRadius = barRadius,
        _barBackgroundRadius = barBackgroundRadius;

  @override
  double computeMinIntrinsicWidth(double width) => 100.0;

  @override
  double computeMaxIntrinsicWidth(double height) => 100.0;

  @override
  double computeMinIntrinsicHeight(double width) => _height;

  @override
  double computeMaxIntrinsicHeight(double width) => _height;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    double desiredWidth = constraints.hasBoundedWidth ? constraints.maxWidth : 100.0;
    double desiredHeight = _height;
    Size desiredSize = Size(desiredWidth, desiredHeight);
    return constraints.constrain(desiredSize);
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double maxDx = offset.dx + size.width;
    double minDy = offset.dy + size.height;
    RRect rect = RRect.fromLTRBR(
      offset.dx,
      offset.dy,
      maxDx,
      minDy,
      _barBackgroundRadius ?? const Radius.circular(16.0),
    );
    void onPainting() {
      context.canvas.drawRRect(
        rect, Paint()..color = _barBackgroundColor..style = PaintingStyle.fill
      );
      double offsetX2 = offset.dx + size.width * _barValue;
      double offsetX1 = offsetX2 - size.width;
      context.canvas.drawRRect(
        RRect.fromLTRBR(
          offsetX1,
          offset.dy,
          offsetX2,
          minDy,
          _barRadius ?? const Radius.circular(16.0),
        ),
        Paint()..color = _barColor
          ..style = PaintingStyle.fill
      );
    }
    context.clipRRectAndPaint(rect, Clip.antiAlias, paintBounds, onPainting);
  }
}