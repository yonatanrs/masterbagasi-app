import '../../../../domain/entity/delivery/delivery_review.dart';
import '../list_item_controller_state.dart';

abstract class DeliveryReviewListItemControllerState extends ListItemControllerState {
  DeliveryReview deliveryReview;

  DeliveryReviewListItemControllerState({
    required this.deliveryReview
  });
}