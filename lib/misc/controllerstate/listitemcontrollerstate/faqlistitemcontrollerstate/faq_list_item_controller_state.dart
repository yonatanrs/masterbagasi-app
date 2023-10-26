import '../../../../domain/entity/faq/faq.dart';
import '../list_item_controller_state.dart';

class FaqListItemControllerState extends ListItemControllerState {
  Faq faq;
  bool isExpanded;
  void Function()? onTap;

  FaqListItemControllerState({
    required this.faq,
    required this.isExpanded,
    this.onTap
  });
}

class FaqListItemValue {
  Faq faq;
  bool isExpanded;

  FaqListItemValue({
    required this.faq,
    required this.isExpanded
  });
}