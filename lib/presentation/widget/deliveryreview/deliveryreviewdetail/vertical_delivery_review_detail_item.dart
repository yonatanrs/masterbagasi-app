import 'delivery_review_detail_item.dart';

class VerticalDeliveryReviewDetailItem extends DeliveryReviewDetailItem {
  @override
  double? get itemWidth => null;

  const VerticalDeliveryReviewDetailItem({
    super.key,
    required super.deliveryReview,
    required super.deliveryReviewDetailType,
    super.onDeliveryReviewRatingTap
  });
}