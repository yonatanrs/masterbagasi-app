import 'list_item_controller_state.dart';

class BuilderListItemControllerState extends ListItemControllerState {
  ListItemControllerState Function() buildListItemControllerState;

  BuilderListItemControllerState({
    required this.buildListItemControllerState
  });
}