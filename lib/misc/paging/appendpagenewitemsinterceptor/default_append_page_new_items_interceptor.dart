import '../../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../../controllerstate/listitemcontrollerstate/page_keyed_list_item_controller_state.dart';
import 'append_page_new_items_interceptor.dart';

class DefaultAppendPageNewItemsInterceptor<PageKeyType, ItemType> extends AppendPageNewItemsInterceptor<PageKeyType, ItemType> {
  @override
  List<ItemType> intercept(List<ItemType> newItems, PageKeyType? nextPageKey) {
    if (newItems is List<ListItemControllerState>) {
      List<ListItemControllerState> willBeInterceptedNewItems = newItems as List<ListItemControllerState>;
      return willBeInterceptedNewItems.map<ListItemControllerState>((listItemControllerState) => PageKeyedListItemControllerState(
        pageKey: nextPageKey,
        listItemControllerState: listItemControllerState
      )).toList() as List<ItemType>;
    } else {
      return newItems;
    }
  }
}