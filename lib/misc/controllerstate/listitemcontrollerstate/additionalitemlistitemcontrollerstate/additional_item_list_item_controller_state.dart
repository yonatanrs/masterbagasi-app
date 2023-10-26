import '../../../../domain/entity/additionalitem/additional_item.dart';
import '../list_item_controller_state.dart';

class AdditionalItemListItemControllerState extends ListItemControllerState {
  AdditionalItem additionalItem;
  int? no;

  AdditionalItemListItemControllerState({
    required this.additionalItem,
    this.no
  });
}