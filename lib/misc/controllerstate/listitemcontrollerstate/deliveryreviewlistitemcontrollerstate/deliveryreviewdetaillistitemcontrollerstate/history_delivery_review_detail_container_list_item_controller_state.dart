import '../../../../../domain/entity/delivery/delivery_review.dart';
import '../../list_item_controller_state.dart';

class HistoryDeliveryReviewDetailContainerListItemControllerState extends ListItemControllerState {
  List<DeliveryReview> deliveryReviewList;
  void Function() onUpdateState;

  HistoryDeliveryReviewDetailContainerListItemControllerState({
    required this.deliveryReviewList,
    required this.onUpdateState,
  });
}