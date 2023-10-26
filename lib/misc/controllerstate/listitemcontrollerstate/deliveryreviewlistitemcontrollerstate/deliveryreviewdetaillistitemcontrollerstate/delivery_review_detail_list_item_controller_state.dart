import '../../../../../domain/entity/delivery/delivery_review.dart';
import 'base_delivery_review_detail_list_item_controller_state.dart';

enum DeliveryReviewDetailType {
  waitingToBeReviewed, history
}

abstract class DeliveryReviewDetailListItemControllerState extends BaseDeliveryReviewDetailListItemControllerState {
  DeliveryReview deliveryReview;
  DeliveryReviewDetailType deliveryReviewDetailType;
  void Function(int)? onDeliveryReviewRatingTap;

  DeliveryReviewDetailListItemControllerState({
    required this.deliveryReview,
    required this.deliveryReviewDetailType,
    this.onDeliveryReviewRatingTap
  });
}