import 'package:flutter/material.dart';

import '../../misc/color_helper.dart';
import '../../misc/constant.dart';

typedef LabelStyleFunction = TextStyle? Function(TextStyle? oldLabelStyle, Color backgroundColor);
typedef StatedLabelStyleFunction = TextStyle? Function(
  TextStyle? oldLabelStyle,
  Color backgroundColor,
  Color unselectedBackgroundColor,
  bool isSelected
);

TextStyle? _defaultLabelStyleFunction(TextStyle? oldLabelStyle, Color backgroundColor) {
  return oldLabelStyle?.merge(TextStyle(color: ColorHelper.contrastColorFromBackgroundColor(backgroundColor)));
}

TextStyle? _defaultStatedLabelStyleFunction(
  TextStyle? oldLabelStyle,
  Color backgroundColor,
  Color unselectedBackgroundColor,
  bool isSelected
) {
  Color effectiveTextColor = ColorHelper.contrastColorFromBackgroundColor(
    isSelected ? backgroundColor : unselectedBackgroundColor,
    onBrightnessConditionChecking: (brightness, oldLightBrightnessConditionColor, oldDarkBrightnessConditionColor) {
      return brightness == Brightness.light ? backgroundColor : oldDarkBrightnessConditionColor;
    }
  );
  return oldLabelStyle?.merge(TextStyle(color: effectiveTextColor));
}

class ModifiedChip extends Chip {
  @protected
  final LabelStyleFunction? labelStyleFunction;

  const ModifiedChip({
    Key? key,
    Widget? avatar,
    required Widget label,
    this.labelStyleFunction,
    EdgeInsetsGeometry? labelPadding,
    Widget? deleteIcon,
    VoidCallback? onDeleted,
    Color? deleteIconColor,
    bool useDeleteButtonTooltip = true,
    String? deleteButtonTooltipMessage,
    BorderSide? side,
    OutlinedBorder? shape,
    Clip clipBehavior = Clip.none,
    FocusNode? focusNode,
    bool autofocus = false,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? materialTapTargetSize,
    double? elevation,
    Color? shadowColor,
  }) : super(
        key: key,
        avatar: avatar,
        label: label,
        labelStyle: const TextStyle(fontSize: 12.0),
        labelPadding: labelPadding,
        deleteIcon: deleteIcon,
        onDeleted: onDeleted,
        deleteIconColor: deleteIconColor,
        useDeleteButtonTooltip: useDeleteButtonTooltip,
        deleteButtonTooltipMessage: deleteButtonTooltipMessage,
        side: side,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        backgroundColor: backgroundColor,
        padding: padding,
        visualDensity: visualDensity,
        materialTapTargetSize: materialTapTargetSize,
        elevation: elevation,
        shadowColor: shadowColor,
      );

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final ChipThemeData chipTheme = ChipTheme.of(context);
    final Brightness brightness = chipTheme.brightness ?? theme.brightness;
    final ChipThemeData chipDefaults = ChipThemeData.fromDefaults(
      brightness: brightness,
      secondaryColor: brightness == Brightness.dark ? Colors.tealAccent[200]! : theme.primaryColor,
      labelStyle: theme.textTheme.bodyText1!,
    );
    LabelStyleFunction effectiveLabelStyleFunction = labelStyleFunction ?? _defaultLabelStyleFunction;
    Color effectiveBackgroundColor = backgroundColor
      ?? chipTheme.backgroundColor
      ?? theme.chipTheme.backgroundColor
      ?? chipDefaults.backgroundColor
      ?? Constant.colorDefaultChip;
    return RawChip(
      avatar: avatar,
      label: label,
      labelStyle: effectiveLabelStyleFunction(labelStyle, effectiveBackgroundColor),
      labelPadding: labelPadding,
      deleteIcon: deleteIcon,
      onDeleted: onDeleted,
      deleteIconColor: deleteIconColor,
      useDeleteButtonTooltip: useDeleteButtonTooltip,
      deleteButtonTooltipMessage: deleteButtonTooltipMessage,
      tapEnabled: false,
      side: side,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      backgroundColor: backgroundColor,
      padding: padding,
      visualDensity: visualDensity,
      materialTapTargetSize: materialTapTargetSize,
      elevation: elevation,
      shadowColor: shadowColor,
    );
  }
}

class ModifiedChipButton extends StatefulWidget {
  final Widget label;
  final StatedLabelStyleFunction? statedLabelStyleFunction;
  final Color? backgroundColor;
  final Color? unselectedBackgroundColor;
  final bool isSelected;
  final VoidCallback? onTap;
  final ShapeBorder? border;
  final ShapeBorder? unselectedBorder;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const ModifiedChipButton({
    Key? key,
    required this.label,
    this.statedLabelStyleFunction,
    this.backgroundColor,
    this.unselectedBackgroundColor,
    required this.isSelected,
    this.onTap,
    this.border,
    this.unselectedBorder,
    this.padding,
    this.borderRadius
  }) : super(key: key);

  @override
  _ModificationChipButtonState createState() => _ModificationChipButtonState();
}

class _ModificationChipButtonState extends State<ModifiedChipButton> with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData theme = Theme.of(context);
    final ChipThemeData chipTheme = ChipTheme.of(context);
    final Brightness brightness = chipTheme.brightness ?? theme.brightness;
    final ChipThemeData chipDefaults = ChipThemeData.fromDefaults(
      brightness: brightness,
      secondaryColor: brightness == Brightness.dark ? Colors.tealAccent[200]! : theme.primaryColor,
      labelStyle: theme.textTheme.bodyText1!,
    );
    Widget labelText = widget.label;
    final TextStyle labelStyle = chipTheme.labelStyle
      ?? theme.chipTheme.labelStyle
      ?? chipDefaults.labelStyle!;
    late final TextStyle mergedTextStyle;
    if (labelText is Text) {
      if (labelText.style != null) {
        mergedTextStyle = labelText.style!;
      } else {
        mergedTextStyle = const TextStyle(fontSize: 12.0);
      }
    } else {
      mergedTextStyle = const TextStyle(fontSize: 12.0);
    }
    final TextStyle effectiveLabelStyle = labelStyle.merge(mergedTextStyle);
    final Color? resolvedLabelColor = MaterialStateProperty.resolveAs<Color?>(effectiveLabelStyle.color, materialStates);
    final TextStyle resolvedLabelStyle = effectiveLabelStyle.copyWith(color: resolvedLabelColor);
    StatedLabelStyleFunction effectiveStatedLabelStyleFunction = widget.statedLabelStyleFunction ?? _defaultStatedLabelStyleFunction;
    Color effectiveSelectedBackgroundColor = widget.backgroundColor
      ?? chipTheme.backgroundColor
      ?? theme.chipTheme.backgroundColor
      ?? chipDefaults.backgroundColor
      ?? Constant.colorDefaultChip;
    Color effectiveUnselectedBackgroundColor = Colors.white.withOpacity(0);
    BorderRadius borderRadius = widget.borderRadius ?? const BorderRadius.all(Radius.circular(16.0));
    if (labelText is Text) {
      labelText = Text(
        labelText.data ?? "",
        style: effectiveStatedLabelStyleFunction(resolvedLabelStyle, effectiveSelectedBackgroundColor, effectiveUnselectedBackgroundColor, widget.isSelected) ?? resolvedLabelStyle
      );
    }
    ShapeBorder effectiveSelectedBorder = widget.border ?? RoundedRectangleBorder(borderRadius: borderRadius);
    ShapeBorder effectiveUnselectedBorder = widget.unselectedBorder ?? RoundedRectangleBorder(
      borderRadius: borderRadius,
      side: BorderSide(
        color: effectiveSelectedBackgroundColor,
        width: 1.7
      )
    );
    ShapeBorder effectiveBorder = widget.isSelected ? effectiveSelectedBorder : effectiveUnselectedBorder;
    Color effectiveBackgroundColor = widget.isSelected ? effectiveSelectedBackgroundColor : effectiveUnselectedBackgroundColor;
    return Material(
      shape: effectiveBorder,
      color: effectiveBackgroundColor,
      animationDuration: Duration.zero,
      child: InkWell(
        onTap: widget.isSelected ? null : widget.onTap,
        customBorder: effectiveBorder,
        child: Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 11.0),
          child: DefaultTextStyle(
            overflow: TextOverflow.fade,
            textAlign: TextAlign.start,
            maxLines: 1,
            softWrap: false,
            style: resolvedLabelStyle,
            child: labelText,
          )
        ),
      ),
    );
  }
}