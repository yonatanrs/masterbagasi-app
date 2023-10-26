import 'list_item_controller_state.dart';
import 'non_expanded_item_in_row_controller_state.dart';

class VirtualSpacingListItemControllerState extends ListItemControllerState implements NonExpandedItemInRowControllerState {
  double? width;
  double? height;

  VirtualSpacingListItemControllerState({
    this.width,
    this.height
  });
}