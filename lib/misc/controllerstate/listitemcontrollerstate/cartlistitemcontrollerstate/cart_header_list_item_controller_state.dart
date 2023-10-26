import '../list_item_controller_state.dart';

class CartHeaderListItemControllerState extends ListItemControllerState {
  bool isSelected;
  void Function() onChangeSelected;

  CartHeaderListItemControllerState({
    required this.isSelected,
    required this.onChangeSelected
  });
}