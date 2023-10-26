import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ModifiedDivider extends StatelessWidget {
  final Color? lineColor;
  final double lineHeight;
  final BorderRadius borderRadius;

  const ModifiedDivider({
    Key? key,
    this.lineColor,
    this.lineHeight = 1.5,
    this.borderRadius = const BorderRadius.all(Radius.zero)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ModifiedDividerAppearance(
      lineColor: lineColor ?? Theme.of(context).dividerTheme.color ?? Colors.grey,
      lineHeight: lineHeight,
      borderRadius: borderRadius
    );
  }
}

class _ModifiedDividerAppearance extends LeafRenderObjectWidget {
  final Color lineColor;
  final double lineHeight;
  final BorderRadius borderRadius;

  const _ModifiedDividerAppearance({
    Key? key,
    required this.lineColor,
    required this.lineHeight,
    required this.borderRadius
  }) : super(key: key);

  @override
  _ModifiedDividerAppearanceRenderer createRenderObject(BuildContext context) => _ModifiedDividerAppearanceRenderer(
    lineColor: lineColor,
    lineWidth: lineHeight,
    borderRadius: borderRadius
  );

  @override
  void updateRenderObject(BuildContext context, covariant _ModifiedDividerAppearanceRenderer renderObject) {
    renderObject..lineColor = lineColor
      ..lineHeight = lineHeight
      ..borderRadius = borderRadius;
  }
}

class _ModifiedDividerAppearanceRenderer extends RenderProxyBox {
  Color _lineColor;
  Color get lineColor => _lineColor;
  set lineColor(Color value) {
    _lineColor = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  double _lineHeight;
  double get lineHeight => _lineHeight;
  set lineHeight(double value) {
    _lineHeight = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  BorderRadius _borderRadius;
  BorderRadius get borderRadius => _borderRadius;
  set borderRadius(BorderRadius value) {
    _borderRadius = value;
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  _ModifiedDividerAppearanceRenderer({
    required Color lineColor,
    required double lineWidth,
    required BorderRadius borderRadius
  }) : _lineColor = lineColor,
      _lineHeight = lineWidth,
      _borderRadius = borderRadius;

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, _lineHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        offset.dx,
        offset.dy,
        offset.dx + size.width,
        offset.dy + size.height,
        topLeft: _borderRadius.topLeft,
        topRight: _borderRadius.topRight,
        bottomLeft: _borderRadius.bottomLeft,
        bottomRight: _borderRadius.bottomRight
      ),
      Paint()..color = _lineColor
        ..style = PaintingStyle.fill
    );
  }
}