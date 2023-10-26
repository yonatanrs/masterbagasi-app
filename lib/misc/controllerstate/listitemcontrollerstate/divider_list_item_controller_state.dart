import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

class DividerListItemControllerState extends ListItemControllerState {
  final Color? lineColor;
  final double lineHeight;
  final BorderRadius borderRadius;

  DividerListItemControllerState({
    Key? key,
    this.lineColor,
    this.lineHeight = 1.5,
    this.borderRadius = const BorderRadius.all(Radius.zero)
  });
}