import 'package:flutter/material.dart';

import '../modified_shimmer.dart';
import 'delivery_review_item.dart';

class VerticalDeliveryReviewItem extends DeliveryReviewItem {
  @override
  double? get itemWidth => null;

  const VerticalDeliveryReviewItem({
    super.key,
    required super.deliveryReview
  });
}

class ShimmerVerticalDeliveryReviewItem extends VerticalDeliveryReviewItem {
  const ShimmerVerticalDeliveryReviewItem({
    Key? key,
    required super.deliveryReview
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ModifiedShimmer.fromColors(
        child: super.build(context)
      ),
    );
  }
}