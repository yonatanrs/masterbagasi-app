import 'delivery_review_detail_item.dart';

class HorizontalDeliveryReviewDetailItem extends DeliveryReviewDetailItem {
  @override
  double? get itemWidth => 180.0;

  const HorizontalDeliveryReviewDetailItem({
    super.key,
    required super.deliveryReview,
    required super.deliveryReviewDetailType
  });
}