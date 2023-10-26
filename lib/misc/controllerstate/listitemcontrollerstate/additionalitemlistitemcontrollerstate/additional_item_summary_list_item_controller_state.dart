import '../../../../domain/entity/additionalitem/additional_item.dart';
import '../list_item_controller_state.dart';

class AdditionalItemSummaryListItemControllerState extends ListItemControllerState {
  List<AdditionalItem> additionalItemList;

  AdditionalItemSummaryListItemControllerState({
    required this.additionalItemList
  });
}