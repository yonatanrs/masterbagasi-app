import '../../../../domain/entity/faq/faq.dart';
import '../list_item_controller_state.dart';

class FaqDetailListItemControllerState extends ListItemControllerState {
  Faq faq;

  FaqDetailListItemControllerState({
    required this.faq
  });
}