import 'list_item_controller_state.dart';

mixin SupportVerticalGridListItemControllerStateMixin on ListItemControllerState {
  int get spanCount => 1;
  int get maxRow => 2;
}