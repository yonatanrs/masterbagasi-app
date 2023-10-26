import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

class ColumnContainerListItemControllerState extends ListItemControllerState {
  EdgeInsetsGeometry? padding;
  List<ListItemControllerState> columnChildListItemControllerState;

  ColumnContainerListItemControllerState({
    this.padding,
    required this.columnChildListItemControllerState
  });
}