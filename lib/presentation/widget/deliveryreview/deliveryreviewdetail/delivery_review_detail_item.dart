import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../../domain/entity/delivery/delivery_review.dart';
import '../../../../misc/controllerstate/listitemcontrollerstate/deliveryreviewlistitemcontrollerstate/deliveryreviewdetaillistitemcontrollerstate/delivery_review_detail_list_item_controller_state.dart';
import '../../../../misc/date_util.dart';
import '../../modifiedcachednetworkimage/product_modified_cached_network_image.dart';
import '../../profile_picture_cache_network_image.dart';
import '../../rating_indicator.dart';

abstract class DeliveryReviewDetailItem extends StatelessWidget {
  final DeliveryReviewDetailType deliveryReviewDetailType;
  final DeliveryReview deliveryReview;
  final void Function(int)? onDeliveryReviewRatingTap;

  @protected
  double? get itemWidth;

  const DeliveryReviewDetailItem({
    Key? key,
    required this.deliveryReviewDetailType,
    required this.deliveryReview,
    this.onDeliveryReviewRatingTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (deliveryReviewDetailType == DeliveryReviewDetailType.waitingToBeReviewed) {
      return _waitingToBeReviewedDeliveryReviewDetailWidget(context);
    } else if (deliveryReviewDetailType == DeliveryReviewDetailType.history) {
      return _historyDeliveryReviewDetailWidget(context);
    } else {
      return Container();
    }
  }

  Widget _historyDeliveryReviewDetailWidget(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.0);
    return SizedBox(
      width: itemWidth,
      child: Padding(
        // Use padding widget for avoiding shadow elevation overlap.
        padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
        child: Material(
          borderRadius: borderRadius,
          elevation: 3,
          child: InkWell(
            borderRadius: borderRadius,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: borderRadius
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        child: ProductModifiedCachedNetworkImage(
                          imageUrl: deliveryReview.productImageUrl.toEmptyStringNonNull,
                        )
                      )
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateUtil.standardDateFormat4.format(deliveryReview.reviewDate), style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 5),
                        Text(deliveryReview.productName.toStringNonNull, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        RatingIndicator(
                          rating: deliveryReview.rating
                        ),
                        const SizedBox(height: 10),
                        Text(deliveryReview.review),
                      ],
                    ),
                  )
                ],
              )
            )
          )
        ),
      )
    );
  }

  Widget _waitingToBeReviewedDeliveryReviewDetailWidget(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.0);
    return SizedBox(
      width: itemWidth,
      child: Padding(
        // Use padding widget for avoiding shadow elevation overlap.
        padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
        child: Material(
          borderRadius: borderRadius,
          elevation: 3,
          child: InkWell(
            borderRadius: borderRadius,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: borderRadius
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        child: ProductModifiedCachedNetworkImage(
                          imageUrl: deliveryReview.productImageUrl.toEmptyStringNonNull,
                        )
                      )
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(DateUtil.standardDateFormat4.format(deliveryReview.reviewDate), style: const TextStyle(fontSize: 12)),
                        const SizedBox(height: 5),
                        Text(deliveryReview.productName.toStringNonNull, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        RatingIndicator(
                          rating: 0.0,
                          ratingSize: 30,
                          onTapRating: onDeliveryReviewRatingTap != null ? (rating) => onDeliveryReviewRatingTap!(rating) : null,
                        ),
                      ],
                    ),
                  )
                ],
              )
            )
          )
        ),
      )
    );
  }
}