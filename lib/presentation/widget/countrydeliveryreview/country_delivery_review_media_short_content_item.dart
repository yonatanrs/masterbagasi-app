import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entity/delivery/countrydeliveryreviewmedia/country_delivery_review_media.dart';
import '../../../misc/constant.dart';
import '../../../misc/dialog_helper.dart';
import '../../page/modaldialogpage/country_delivery_review_media_detail_modal_dialog_page.dart';
import '../modified_shimmer.dart';
import '../tap_area.dart';
import 'country_delivery_review_media_short_content_detail_item.dart';

class ShimmerCountryDeliveryReviewMediaShortContentItem extends StatelessWidget {
  const ShimmerCountryDeliveryReviewMediaShortContentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ModifiedShimmer.fromColors(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Sample Photo & Video",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.black
                    )
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "More".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black
                  )
                ),
              ],
            ),
            const SizedBox(height: 10),
            Builder(
              builder: (context) {
                int length = 5;
                return Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: [
                    ...List.generate(length, (index) => 1).map<Widget>(
                      (value) {
                        double totalGapWidth = 8 * (length - 1) + Constant.paddingListItem * 2;
                        double size = (MediaQuery.of(context).size.width - totalGapWidth) / length;
                        return Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0)
                          ),
                        );
                      }
                    )
                  ],
                );
              }
            )
          ]
        ),
      )
    );
  }
}

class CountryDeliveryReviewMediaShortContentItem extends StatelessWidget {
  final List<CountryDeliveryReviewMedia> countryDeliveryReviewMediaList;
  final bool showAll;

  const CountryDeliveryReviewMediaShortContentItem({
    super.key,
    required this.countryDeliveryReviewMediaList,
    this.showAll = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Foto & Video Ulasan MBestie".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              const SizedBox(width: 10),
              TapArea(
                onTap: () async {
                  await DialogHelper.showModalDialogPage<void, List<CountryDeliveryReviewMedia>>(
                    context: context,
                    modalDialogPageBuilder: (context, parameter) => CountryDeliveryReviewMediaDetailModalDialogPage(
                      countryDeliveryReviewMediaList: parameter!,
                      contextForOpeningMediaView: () {
                        return context;
                      },
                    ),
                    parameter: countryDeliveryReviewMediaList,
                  );
                },
                child: Text(
                  "More".tr,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Constant.colorMain
                  )
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CountryDeliveryReviewMediaShortContentDetailItem(
            countryDeliveryReviewMediaList: countryDeliveryReviewMediaList,
            showAll: showAll,
          )
        ]
      ),
    );
  }
}