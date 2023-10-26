import 'list_item_controller_state_wrapper_parameter.dart';

class SearchFilterGroupListItemControllerStateWrapperParameter extends ListItemControllerStateWrapperParameter {
  void Function()? onUpdateListItemControllerState;

  SearchFilterGroupListItemControllerStateWrapperParameter({
    this.onUpdateListItemControllerState
  });
}