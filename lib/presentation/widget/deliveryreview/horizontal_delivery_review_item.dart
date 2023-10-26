import 'delivery_review_item.dart';

class HorizontalDeliveryReviewItem extends DeliveryReviewItem {
  @override
  double? get itemWidth => 220.0;

  const HorizontalDeliveryReviewItem({
    super.key,
    required super.deliveryReview
  });
}