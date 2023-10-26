import 'package:flutter/material.dart';

class ModifiedLoadingIndicator extends StatelessWidget {
  final Widget Function(ModifiedLoadingIndicatorParameter?)? customIndicator;
  final ModifiedLoadingIndicatorParameter? modifiedLoadingIndicatorParameter;

  const ModifiedLoadingIndicator({
    Key? key,
    this.customIndicator,
    this.modifiedLoadingIndicatorParameter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customIndicator != null ? customIndicator!(modifiedLoadingIndicatorParameter) : CircularProgressIndicator(color: modifiedLoadingIndicatorParameter?.color);
  }
}

class ModifiedLoadingIndicatorParameter {
  Color? color;

  ModifiedLoadingIndicatorParameter({
    required this.color
  });
}