import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

typedef WidgetSubstitution = Widget Function(BuildContext context, int index);

class WidgetSubstitutionListItemControllerState extends ListItemControllerState {
  WidgetSubstitution widgetSubstitution;

  WidgetSubstitutionListItemControllerState({
    required this.widgetSubstitution
  });
}