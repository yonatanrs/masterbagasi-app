import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

class PaddingContainerListItemControllerState extends ListItemControllerState {
  EdgeInsetsGeometry padding;
  ListItemControllerState paddingChildListItemControllerState;

  PaddingContainerListItemControllerState({
    required this.padding,
    required this.paddingChildListItemControllerState
  });
}