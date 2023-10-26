import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

class DecoratedContainerListItemControllerState extends ListItemControllerState {
  EdgeInsetsGeometry? padding;
  Decoration decoration;
  ListItemControllerState decoratedChildListItemControllerState;

  DecoratedContainerListItemControllerState({
    this.padding,
    required this.decoration,
    required this.decoratedChildListItemControllerState
  });
}