import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

class ColorfulDividerListItemControllerState extends ListItemControllerState {
  final List<Color> lineColorList;
  final double lineHeight;
  final BorderRadius borderRadius;

  ColorfulDividerListItemControllerState({
    Key? key,
    required this.lineColorList,
    this.lineHeight = 1.5,
    this.borderRadius = const BorderRadius.all(Radius.zero)
  });
}