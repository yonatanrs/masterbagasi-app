import 'list_item_controller_state.dart';
import 'non_expanded_item_in_row_controller_state.dart';

class NonExpandedItemInRowChildControllerState extends ListItemControllerState implements NonExpandedItemInRowControllerState {
  ListItemControllerState childListItemControllerState;

  NonExpandedItemInRowChildControllerState({
    required this.childListItemControllerState
  });
}