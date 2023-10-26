import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/typedef.dart';
import 'package:masterbagasi/misc/validation/validation_result.dart';
import 'package:sizer/sizer.dart';

import '../../misc/error/validation_error.dart';
import '../../misc/validation/validator/validator.dart';

class Field extends StatelessWidget {
  final String? fieldName;
  final WidgetBuilderWithValidatorResult child;
  final WidgetBuilderWithValidatorResult? validationResultDescriptionChild;
  final Validator? validator;
  final CrossAxisAlignment alignment;

  const Field({
    Key? key,
    this.fieldName,
    required this.child,
    this.validationResultDescriptionChild,
    this.validator,
    this.alignment = CrossAxisAlignment.start
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return validator != null ? ValueListenableBuilder(
      valueListenable: validator!.validationNotifier,
      builder: (context, result, widget) => _buildField(context)
    ) : _buildField(context);
  }

  Widget _buildField(BuildContext context) {
    List<Widget> columnWidgetList = <Widget>[];
    if (fieldName != null) {
      columnWidgetList.addAll(<Widget>[
        Text(
          fieldName!,
          style: Theme.of(context).textTheme.bodyMedium
        ),
        SizedBox(height: 2.h),
      ]);
    }
    ValidationResult validationResult = validator?.validationResult ?? SuccessValidationResult();
    columnWidgetList.add(child(context, validationResult, validator));
    if (validationResult is FailedValidationResult) {
      String errorText = "";
      ThemeData themeData = Theme.of(context);
      InputDecorationTheme inputDecorationTheme = themeData.inputDecorationTheme;
      InputDecoration inputDecoration = const InputDecoration().applyDefaults(inputDecorationTheme);
      dynamic e = validationResult.e;
      if (e is ValidationError) {
        errorText = e.message;
      } else {
        errorText = e;
      }
      final Color color = inputDecoration.enabled ? themeData.errorColor : Colors.transparent;
      TextStyle? errorTextStyle = themeData.textTheme.caption!.copyWith(color: color).merge(inputDecoration.errorStyle);
      columnWidgetList.addAll(<Widget>[
        SizedBox(height: 1.h),
        validationResultDescriptionChild != null ? validationResultDescriptionChild!(context, validationResult, validator) : Builder(
          builder: (context) => Text(errorText, style: errorTextStyle)
        ),
      ]);
    }
    return Column(
      crossAxisAlignment: alignment,
      children: columnWidgetList
    );
  }
}