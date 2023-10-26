import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

class RowContainerListItemControllerState extends ListItemControllerState {
  EdgeInsetsGeometry? padding;
  List<ListItemControllerState> rowChildListItemControllerState;

  RowContainerListItemControllerState({
    this.padding,
    required this.rowChildListItemControllerState
  });
}