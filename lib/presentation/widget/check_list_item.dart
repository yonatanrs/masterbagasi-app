import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../misc/constant.dart';

class CheckListItem extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool toggleable;
  final Color? activeColor;
  final Color? activeStrokeColor;
  final MaterialStateProperty<Color?>? fillColor;
  final MaterialStateProperty<Color?>? strokeColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? checkColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final double indentation;
  final bool reverse;
  final double spaceBetweenCheckListAndTitle;
  final double spaceBetweenTitleAndContent;
  final bool showCheck;
  final EdgeInsetsGeometry? padding;

  const CheckListItem({
    Key? key,
    this.title,
    this.content,
    required this.value,
    required this.onChanged,
    this.toggleable = false,
    this.activeColor,
    this.activeStrokeColor,
    this.fillColor,
    this.strokeColor,
    this.focusColor,
    this.hoverColor,
    this.checkColor,
    this.overlayColor,
    this.splashRadius,
    this.shape,
    this.side,
    this.indentation = 0.0,
    this.reverse = false,
    this.spaceBetweenCheckListAndTitle = 10,
    this.spaceBetweenTitleAndContent = 10,
    this.showCheck = true,
    this.padding
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: themeData.copyWith(toggleableActiveColor: themeData.colorScheme.primary),
      child: _RawCheckListItem(
        title: title,
        content: content,
        value: value,
        onChanged: onChanged,
        toggleable: toggleable,
        activeColor: activeColor,
        activeStrokeColor: activeStrokeColor,
        fillColor: fillColor,
        strokeColor: strokeColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        checkColor: checkColor,
        overlayColor: overlayColor,
        splashRadius: splashRadius,
        indentation: indentation,
        reverse: reverse,
        spaceBetweenCheckListAndTitle: spaceBetweenCheckListAndTitle,
        spaceBetweenTitleAndContent: spaceBetweenTitleAndContent,
        showCheck: showCheck,
        padding: padding
      )
    );
  }
}

class _RawCheckListItem extends StatefulWidget {
  final Widget? title;
  final Widget? content;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool toggleable;
  final Color? activeColor;
  final Color? activeStrokeColor;
  final MaterialStateProperty<Color?>? fillColor;
  final MaterialStateProperty<Color?>? strokeColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? checkColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final double? splashRadius;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final double indentation;
  final bool reverse;
  final double spaceBetweenCheckListAndTitle;
  final double spaceBetweenTitleAndContent;
  final bool showCheck;
  final EdgeInsetsGeometry? padding;

  const _RawCheckListItem({
    Key? key,
    this.title,
    this.content,
    required this.value,
    required this.onChanged,
    this.toggleable = false,
    this.activeColor,
    this.activeStrokeColor,
    this.fillColor,
    this.strokeColor,
    this.focusColor,
    this.hoverColor,
    this.checkColor,
    this.overlayColor,
    this.splashRadius,
    this.shape,
    this.side,
    required this.indentation,
    required this.reverse,
    required this.spaceBetweenCheckListAndTitle,
    required this.spaceBetweenTitleAndContent,
    required this.showCheck,
    required this.padding
  }) : super(key: key);

  bool get _selected => value;

  @override
  _RawRadioListItemState createState() => _RawRadioListItemState();
}

class _RawRadioListItemState extends State<_RawCheckListItem> with TickerProviderStateMixin, ToggleableStateMixin {
  final _ModifiedCheckPainter _modifiedCheckPainter = _ModifiedCheckPainter();
  bool? _previousValue;

  @override
  void initState() {
    super.initState();
    _previousValue = widget.value;
  }

  @override
  void didUpdateWidget(_RawCheckListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._selected != oldWidget._selected) {
      animateToValue();
    }
  }

  @override
  void dispose() {
    _modifiedCheckPainter.dispose();
    super.dispose();
  }

  MaterialStateProperty<Color?> get _widgetFillColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return widget.activeColor;
      }
      return null;
    });
  }

  MaterialStateProperty<Color?> get _widgetFillStrokeColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return widget.activeStrokeColor;
      }
      return null;
    });
  }

  MaterialStateProperty<Color> get _defaultFillColor {
    final ThemeData themeData = Theme.of(context);
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return themeData.disabledColor;
      }
      if (states.contains(MaterialState.selected)) {
        return themeData.toggleableActiveColor;
      }
      return themeData.unselectedWidgetColor;
    });
  }

  MaterialStateProperty<Color> get _defaultStrokeColor {
    final ThemeData themeData = Theme.of(context);
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return themeData.disabledColor;
      }
      if (states.contains(MaterialState.selected)) {
        return themeData.unselectedWidgetColor;
      }
      return themeData.unselectedWidgetColor;
    });
  }

  BorderSide? _resolveSide(BorderSide? side) {
    if (side is MaterialStateBorderSide) {
      return MaterialStateProperty.resolveAs<BorderSide?>(side, states);
    } else if (!states.contains(MaterialState.selected)) {
      return side;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>((Set<MaterialState> states) {
      return MaterialStateProperty.resolveAs<MouseCursor?>(null, states)
          ?? themeData.radioTheme.mouseCursor?.resolve(states)
          ?? MaterialStateProperty.resolveAs<MouseCursor>(MaterialStateMouseCursor.clickable, states);
    });

    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between.
    final Set<MaterialState> activeStates = states..add(MaterialState.selected);
    final Set<MaterialState> inactiveStates = states..remove(MaterialState.selected);
    final Color effectiveActiveColor = widget.fillColor?.resolve(activeStates)
        ?? _widgetFillColor.resolve(activeStates)
        ?? themeData.radioTheme.fillColor?.resolve(activeStates)
        ?? _defaultFillColor.resolve(activeStates);
    final Color effectiveActiveStrokeColor = widget.strokeColor?.resolve(activeStates)
        ?? _widgetFillStrokeColor.resolve(activeStates)
        ?? themeData.radioTheme.fillColor?.resolve(activeStates)
        ?? _defaultStrokeColor.resolve(activeStates);
    final Color effectiveInactiveColor = widget.fillColor?.resolve(inactiveStates)
        ?? _widgetFillColor.resolve(inactiveStates)
        ?? themeData.radioTheme.fillColor?.resolve(inactiveStates)
        ?? _defaultFillColor.resolve(inactiveStates);
    final Color effectiveInactiveStrokeColor = widget.strokeColor?.resolve(inactiveStates)
        ?? _widgetFillStrokeColor.resolve(inactiveStates)
        ?? themeData.radioTheme.fillColor?.resolve(inactiveStates)
        ?? _defaultStrokeColor.resolve(inactiveStates);

    final Set<MaterialState> focusedStates = states..add(MaterialState.focused);
    final Color effectiveFocusOverlayColor = widget.overlayColor?.resolve(focusedStates)
        ?? widget.focusColor
        ?? themeData.radioTheme.overlayColor?.resolve(focusedStates)
        ?? themeData.focusColor;

    final Set<MaterialState> hoveredStates = states..add(MaterialState.hovered);
    final Color effectiveHoverOverlayColor = widget.overlayColor?.resolve(hoveredStates)
        ?? widget.hoverColor
        ?? themeData.radioTheme.overlayColor?.resolve(hoveredStates)
        ?? themeData.hoverColor;

    final Set<MaterialState> activePressedStates = activeStates..add(MaterialState.pressed);
    final Color effectiveActivePressedOverlayColor = widget.overlayColor?.resolve(activePressedStates)
        ?? themeData.radioTheme.overlayColor?.resolve(activePressedStates)
        ?? effectiveActiveColor.withAlpha(kRadialReactionAlpha);

    final Set<MaterialState> inactivePressedStates = inactiveStates..add(MaterialState.pressed);
    final Color effectiveInactivePressedOverlayColor = widget.overlayColor?.resolve(inactivePressedStates)
        ?? themeData.radioTheme.overlayColor?.resolve(inactivePressedStates)
        ?? effectiveActiveColor.withAlpha(kRadialReactionAlpha);
    final Color effectiveCheckColor = widget.checkColor
        ?? themeData.checkboxTheme.checkColor?.resolve(states)
        ?? const Color(0xFFFFFFFF);
    List<Widget> rowWidget = [
      Expanded(
        child: widget.title != null ? widget.title! : Text(widget.value.toString())
      ),
      if (widget.showCheck) ...[
        if (widget.spaceBetweenCheckListAndTitle > 0.0) SizedBox(width: widget.spaceBetweenCheckListAndTitle),
        IgnorePointer(
          child: Semantics(
            inMutuallyExclusiveGroup: true,
            checked: widget._selected,
            child: buildToggleable(
              focusNode: null,
              autofocus: false,
              mouseCursor: effectiveMouseCursor,
              size: const Size(20, 20),
              painter: _modifiedCheckPainter
                ..position = position
                ..reaction = reaction
                ..reactionFocusFade = reactionFocusFade
                ..reactionHoverFade = reactionHoverFade
                ..inactiveReactionColor = effectiveInactivePressedOverlayColor
                ..reactionColor = effectiveActivePressedOverlayColor
                ..hoverColor = effectiveHoverOverlayColor
                ..focusColor = effectiveFocusOverlayColor
                ..splashRadius = widget.splashRadius ?? themeData.radioTheme.splashRadius ?? kRadialReactionRadius
                ..downPosition = downPosition
                ..isFocused = states.contains(MaterialState.focused)
                ..isHovered = states.contains(MaterialState.hovered)
                ..activeColor = effectiveActiveColor
                ..activeStrokeColor = effectiveActiveStrokeColor
                ..inactiveColor = effectiveInactiveColor
                ..inactiveStrokeColor = effectiveInactiveStrokeColor
                ..checkColor = effectiveCheckColor
                ..value = value
                ..previousValue = _previousValue
                ..shape = widget.shape ?? themeData.checkboxTheme.shape ?? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(1.0)),
                )
                ..side = _resolveSide(widget.side) ?? _resolveSide(themeData.checkboxTheme.side),
            ),
          ),
        )
      ]
    ];
    List<Widget> columnWidget = [
      Row(children: widget.reverse ? rowWidget.reversed.toList() : rowWidget),
    ];
    if (widget.content != null) {
      columnWidget.addAll(<Widget>[
        SizedBox(height: widget.spaceBetweenTitleAndContent),
        widget.content!
      ]);
    }
    EdgeInsetsGeometry effectivePadding = widget.padding ?? EdgeInsets.all(Constant.paddingListItem);
    EdgeInsetsGeometry? effectiveDuplicatePadding;
    if (effectivePadding is EdgeInsets) {
      effectiveDuplicatePadding = effectivePadding.copyWith(
        left: effectivePadding.left + widget.indentation
      );
    } else if (effectivePadding is EdgeInsetsDirectional) {
      effectiveDuplicatePadding = EdgeInsetsDirectional.only(
        start: effectivePadding.start + widget.indentation,
        top: effectivePadding.top,
        bottom: effectivePadding.bottom,
        end: effectivePadding.end
      );
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (!isInteractive) {
            return;
          }
          switch (value) {
            case false:
              onChanged!(true);
              break;
            case true:
              onChanged!(tristate ? null : false);
              break;
            case null:
              onChanged!(false);
              break;
          }
          context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
        },
        child: Padding(
          padding: effectiveDuplicatePadding ?? effectivePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnWidget
          )
        )
      )
    );
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged;

  @override
  bool get tristate => widget.toggleable;

  @override
  bool? get value => widget._selected;
}

abstract class _ModifiedToggleablePainter extends ToggleablePainter {
  Color get checkColor => _checkColor!;
  Color? _checkColor;
  set checkColor(Color value) {
    if (_checkColor == value) {
      return;
    }
    _checkColor = value;
    notifyListeners();
  }

  bool? get value => _value;
  bool? _value;
  set value(bool? value) {
    if (_value == value) {
      return;
    }
    _value = value;
    notifyListeners();
  }

  bool? get previousValue => _previousValue;
  bool? _previousValue;
  set previousValue(bool? value) {
    if (_previousValue == value) {
      return;
    }
    _previousValue = value;
    notifyListeners();
  }

  OutlinedBorder get shape => _shape!;
  OutlinedBorder? _shape;
  set shape(OutlinedBorder value) {
    if (_shape == value) {
      return;
    }
    _shape = value;
    notifyListeners();
  }

  BorderSide? get side => _side;
  BorderSide? _side;
  set side(BorderSide? value) {
    if (_side == value) {
      return;
    }
    _side = value;
    notifyListeners();
  }

  Color get activeStrokeColor => _activeStrokeColor!;
  Color? _activeStrokeColor;
  set activeStrokeColor(Color value) {
    if (_activeStrokeColor == value) {
      return;
    }
    _activeStrokeColor = value;
    notifyListeners();
  }

  Color get inactiveStrokeColor => _inactiveStrokeColor!;
  Color? _inactiveStrokeColor;
  set inactiveStrokeColor(Color value) {
    if (_inactiveStrokeColor == value) {
      return;
    }
    _inactiveStrokeColor = value;
    notifyListeners();
  }
}

const double _kEdgeSize = Checkbox.width;
const double _kStrokeWidth = 2.0;

class _ModifiedCheckPainter extends _ModifiedToggleablePainter {
  // The square outer bounds of the checkbox at t, with the specified origin.
  // At t == 0.0, the outer rect's size is _kEdgeSize (Checkbox.width)
  // At t == 0.5, .. is _kEdgeSize - _kStrokeWidth
  // At t == 1.0, .. is _kEdgeSize
  Rect _outerRectAt(Offset origin, double t) {
    final double inset = 1.0 - (t - 0.5).abs() * 2.0;
    final double size = _kEdgeSize - inset * _kStrokeWidth;
    final Rect rect = Rect.fromLTWH(origin.dx + inset, origin.dy + inset, size, size);
    return rect;
  }

  // The checkbox's border color if value == false, or its fill color when
  // value == true or null.
  Color _colorAt(double t) {
    // As t goes from 0.0 to 0.25, animate from the inactiveColor to activeColor.
    return t >= 0.25 ? activeColor : Color.lerp(inactiveColor, activeColor, t * 4.0)!;
  }

  // White stroke used to paint the check and dash.
  Paint _createStrokePaint() {
    return Paint()
      ..color = checkColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kStrokeWidth;
  }

  void _drawBox(Canvas canvas, Rect outer, Paint paint, BorderSide? side, bool fill) {
    if (fill) {
      canvas.drawPath(shape.getOuterPath(outer), paint);
    }
    if (side != null) {
      shape.copyWith(side: side).paint(canvas, outer);
    }
  }

  void _drawCheck(Canvas canvas, Offset origin, double t, Paint paint) {
    assert(t >= 0.0 && t <= 1.0);
    // As t goes from 0.0 to 1.0, animate the two check mark strokes from the
    // short side to the long side.
    final Path path = Path();
    const Offset start = Offset(_kEdgeSize * 0.15, _kEdgeSize * 0.45);
    const Offset mid = Offset(_kEdgeSize * 0.4, _kEdgeSize * 0.7);
    const Offset end = Offset(_kEdgeSize * 0.85, _kEdgeSize * 0.25);
    if (t < 0.5) {
      final double strokeT = t * 2.0;
      final Offset drawMid = Offset.lerp(start, mid, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + drawMid.dx, origin.dy + drawMid.dy);
    } else {
      final double strokeT = (t - 0.5) * 2.0;
      final Offset drawEnd = Offset.lerp(mid, end, strokeT)!;
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
      path.lineTo(origin.dx + drawEnd.dx, origin.dy + drawEnd.dy);
    }
    canvas.drawPath(path, paint);
  }

  void _drawDash(Canvas canvas, Offset origin, double t, Paint paint) {
    assert(t >= 0.0 && t <= 1.0);
    // As t goes from 0.0 to 1.0, animate the horizontal line from the
    // mid point outwards.
    const Offset start = Offset(_kEdgeSize * 0.2, _kEdgeSize * 0.5);
    const Offset mid = Offset(_kEdgeSize * 0.5, _kEdgeSize * 0.5);
    const Offset end = Offset(_kEdgeSize * 0.8, _kEdgeSize * 0.5);
    final Offset drawStart = Offset.lerp(start, mid, 1.0 - t)!;
    final Offset drawEnd = Offset.lerp(mid, end, t)!;
    canvas.drawLine(origin + drawStart, origin + drawEnd, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintRadialReaction(canvas: canvas, origin: size.center(Offset.zero));

    final Paint strokePaint = _createStrokePaint();
    final Offset origin = size / 2.0 - const Size.square(_kEdgeSize) / 2.0 as Offset;
    final AnimationStatus status = position.status;
    final double tNormalized = status == AnimationStatus.forward || status == AnimationStatus.completed
        ? position.value
        : 1.0 - position.value;

    // Four cases: false to null, false to true, null to false, true to false
    if (previousValue == false || value == false) {
      final double t = value == false ? 1.0 - tNormalized : tNormalized;
      final Rect outer = _outerRectAt(origin, t);
      final Paint paint = Paint()..color = _colorAt(t);

      if (t <= 0.5) {
        final BorderSide border = side ?? BorderSide(width: 2, color: paint.color);
        _drawBox(canvas, outer, paint, border, false); // only paint the border
      } else {
        _drawBox(canvas, outer, paint, side, true);
        final double tShrink = (t - 0.5) * 2.0;
        if (previousValue == null || value == null) {
          _drawDash(canvas, origin, tShrink, strokePaint);
        } else {
          _drawCheck(canvas, origin, tShrink, strokePaint);
        }
      }
    } else { // Two cases: null to true, true to null
      final Rect outer = _outerRectAt(origin, 1.0);
      final Paint paint = Paint() ..color = _colorAt(1.0);

      _drawBox(canvas, outer, paint, side, true);
      if (tNormalized <= 0.5) {
        final double tShrink = 1.0 - tNormalized * 2.0;
        if (previousValue == true) {
          _drawCheck(canvas, origin, tShrink, strokePaint);
        } else {
          _drawDash(canvas, origin, tShrink, strokePaint);
        }
      } else {
        final double tExpand = (tNormalized - 0.5) * 2.0;
        if (value == true) {
          _drawCheck(canvas, origin, tExpand, strokePaint);
        } else {
          _drawDash(canvas, origin, tExpand, strokePaint);
        }
      }
    }
  }
}