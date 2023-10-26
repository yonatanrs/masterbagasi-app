import 'list_item_controller_state.dart';

class PageKeyedListItemControllerState<PageKeyType> extends ListItemControllerState {
  PageKeyType? pageKey;
  ListItemControllerState? listItemControllerState;

  PageKeyedListItemControllerState({
    this.pageKey,
    this.listItemControllerState
  });
}