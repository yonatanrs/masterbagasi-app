import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

class CardContainerListItemControllerState extends ListItemControllerState {
  BorderRadius borderRadius;
  ListItemControllerState cardContainerChildListItemControllerState;

  CardContainerListItemControllerState({
    required this.borderRadius,
    required this.cardContainerChildListItemControllerState
  });
}