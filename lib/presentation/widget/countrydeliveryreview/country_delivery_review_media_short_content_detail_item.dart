import 'package:flutter/material.dart';

import '../../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../../misc/constant.dart';
import 'country_delivery_review_media_detail_item.dart';

class CountryDeliveryReviewMediaShortContentDetailItem extends StatelessWidget {
  final List<CountryDeliveryReviewMedia> countryDeliveryReviewMediaList;
  final bool showAll;

  const CountryDeliveryReviewMediaShortContentDetailItem({
    super.key,
    required this.countryDeliveryReviewMediaList,
    this.showAll = false
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        int length = 5;
        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            ...(showAll ? countryDeliveryReviewMediaList : countryDeliveryReviewMediaList.take(5)).map<Widget>(
              (value) {
                double totalGapWidth = 8 * (length - 1) + Constant.paddingListItem * 2;
                double size = (MediaQuery.of(context).size.width - totalGapWidth) / length;
                return SizedBox(
                  width: size,
                  height: size,
                  child: CountryDeliveryReviewMediaDetailItem(
                    countryDeliveryReviewMedia: value,
                  )
                );
              }
            )
          ],
        );
      }
    );
  }
}