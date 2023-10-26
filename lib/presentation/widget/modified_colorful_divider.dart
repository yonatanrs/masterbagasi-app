import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../misc/constant.dart';

class ModifiedColorfulDivider extends StatelessWidget {
  final List<Color> lineColorList;
  final double lineHeight;
  final BorderRadius borderRadius;

  const ModifiedColorfulDivider({
    Key? key,
    required this.lineColorList,
    this.lineHeight = 1.5,
    this.borderRadius = const BorderRadius.all(Radius.zero)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ModifiedColorfulDividerAppearance(
      lineColorList: lineColorList,
      lineHeight: lineHeight,
      borderRadius: borderRadius
    );
  }
}

class _ModifiedColorfulDividerAppearance extends LeafRenderObjectWidget {
  final List<Color> lineColorList;
  final double lineHeight;
  final BorderRadius borderRadius;

  const _ModifiedColorfulDividerAppearance({
    Key? key,
    required this.lineColorList,
    required this.lineHeight,
    required this.borderRadius
  }) : super(key: key);

  @override
  _ModifiedDividerAppearanceRenderer createRenderObject(BuildContext context) => _ModifiedDividerAppearanceRenderer(
    lineColorList: lineColorList,
    lineWidth: lineHeight,
    borderRadius: borderRadius
  );

  @override
  void updateRenderObject(BuildContext context, covariant _ModifiedDividerAppearanceRenderer renderObject) {
    renderObject..lineColorList = lineColorList
      ..lineHeight = lineHeight
      ..borderRadius = borderRadius;
  }
}

class _ModifiedDividerAppearanceRenderer extends RenderProxyBox {
  List<Color> _lineColorList;
  List<Color> get lineColorList => _lineColorList;
  set lineColorList(List<Color> value) {
    _lineColorList = value;
    markNeedsPaint();
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  double _lineHeight;
  double get lineHeight => _lineHeight;
  set lineHeight(double value) {
    _lineHeight = value;
    markNeedsPaint();
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  BorderRadius _borderRadius;
  BorderRadius get borderRadius => _borderRadius;
  set borderRadius(BorderRadius value) {
    _borderRadius = value;
    markNeedsPaint();
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }

  _ModifiedDividerAppearanceRenderer({
    required List<Color> lineColorList,
    required double lineWidth,
    required BorderRadius borderRadius
  }) : _lineColorList = lineColorList,
      _lineHeight = lineWidth,
      _borderRadius = borderRadius;

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, _lineHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double eachWidth = size.width / _lineColorList.length;
    int i = 0;
    List<Color> effectiveLineColorList = _lineColorList;
    if (effectiveLineColorList.isEmpty) {
      effectiveLineColorList.add(Constant.colorMain);
    }
    while (i < _lineColorList.length) {
      Color lineColor = _lineColorList[i];
      double dx1 = offset.dx + eachWidth * i;
      double dx2 = dx1 + eachWidth;
      context.canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          dx1,
          offset.dy,
          dx2,
          offset.dy + size.height,
          topLeft: _borderRadius.topLeft,
          topRight: _borderRadius.topRight,
          bottomLeft: _borderRadius.bottomLeft,
          bottomRight: _borderRadius.bottomRight
        ),
        Paint()..color = lineColor
          ..style = PaintingStyle.fill
      );
      i++;
    }
  }
}