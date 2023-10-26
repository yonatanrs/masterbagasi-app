import 'package:flutter/material.dart';

import '../../../domain/entity/delivery/country_delivery_review.dart';
import '../../../misc/date_util.dart';
import '../profile_picture_cache_network_image.dart';
import '../rating_indicator.dart';
import 'country_delivery_review_media_short_content_detail_item.dart';

class CountryDeliveryReviewItem extends StatelessWidget {
  final CountryDeliveryReview countryDeliveryReview;

  const CountryDeliveryReviewItem({
    super.key,
    required this.countryDeliveryReview
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProfilePictureCacheNetworkImage(
                profileImageUrl: countryDeliveryReview.userProfilePicture,
                dimension: 40.0,
              ),
              const SizedBox(width: 10),
              Text(
                countryDeliveryReview.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingIndicator(rating: countryDeliveryReview.rating),
              const SizedBox(width: 10),
              Column(
                children: [
                  const SizedBox(height: 3),
                  Text(
                    DateUtil.standardDateFormat7.format(countryDeliveryReview.reviewDate),
                    style: const TextStyle(
                      fontSize: 12
                    ),
                  ),
                ],
              ),
            ]
          ),
          const SizedBox(height: 10),
          Text(countryDeliveryReview.review),
          if (countryDeliveryReview.countryDeliveryReviewMedia.isNotEmpty) ...[
            const SizedBox(height: 10),
            CountryDeliveryReviewMediaShortContentDetailItem(
              countryDeliveryReviewMediaList: countryDeliveryReview.countryDeliveryReviewMedia,
              showAll: true,
            )
          ]
        ],
      )
    );
  }
}