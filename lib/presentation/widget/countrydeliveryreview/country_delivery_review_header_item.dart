import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/entity/delivery/country_delivery_review_header_content.dart';
import '../../../misc/constant.dart';
import '../../../misc/multi_language_string.dart';
import '../button/custombutton/sized_outline_gradient_button.dart';
import '../modified_shimmer.dart';
import '../modified_svg_picture.dart';
import '../modifiedcachednetworkimage/country_delivery_review_modified_cached_network_image.dart';
import '../modifiedcachednetworkimage/product_entry_header_modified_cached_network_image.dart';

class ShimmerCountryDeliveryReviewHeaderItem extends StatelessWidget {
  const ShimmerCountryDeliveryReviewHeaderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ModifiedShimmer.fromColors(
      child: AspectRatio(
        aspectRatio: Constant.aspectRatioValueCountryDeliveryReviewCountryBackground.toDouble(),
        child: Container(
          color: Colors.black,
        )
      )
    );
  }
}

class CountryDeliveryReviewHeaderItem extends StatelessWidget {
  final CountryDeliveryReviewHeaderContent countryDeliveryReviewHeaderContent;

  const CountryDeliveryReviewHeaderItem({super.key, required this.countryDeliveryReviewHeaderContent});

  @override
  Widget build(BuildContext context) {
    TextStyle getDefaultTextStyle() {
      return TextStyle(
        color: Constant.colorDarkBlue,
        fontWeight: FontWeight.bold
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: Constant.aspectRatioValueCountryDeliveryReviewCountryBackground.toDouble(),
        child: Stack(
          children: [
            Builder(
              builder: (context) {
                return CountryDeliveryReviewModifiedCachedNetworkImage(
                  imageUrl: countryDeliveryReviewHeaderContent.backgroundImageUrl,
                );
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    stops: const [0, 1]
                  )
                )
              ),
            ),
            Positioned(
              left: Constant.paddingListItem,
              bottom: Constant.paddingListItem,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IgnorePointer(
                        child: ExcludeFocus(
                          child: SizedOutlineGradientButton(
                            onPressed: () {},
                            text: countryDeliveryReviewHeaderContent.countryName,
                            childInterceptor: (textStyle) {
                              return Center(
                                child: Text(
                                  countryDeliveryReviewHeaderContent.countryName,
                                  style: textStyle?.copyWith(fontSize: 12),
                                )
                              );
                            },
                            outlineGradientButtonType: OutlineGradientButtonType.outline,
                            outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                            customGradientButtonVariation: (outlineGradientButtonType) {
                              return CustomGradientButtonVariation(
                                outlineGradientButtonType: outlineGradientButtonType,
                                gradient: Constant.buttonGradient2,
                                backgroundColor: Colors.white,
                                textStyle: getDefaultTextStyle()
                              );
                            },
                            customPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: Constant.paddingListItem,
              bottom: Constant.paddingListItem,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: FittedBox(
                            child: Image.asset(Constant.imageStar),
                          )
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${countryDeliveryReviewHeaderContent.rating}/",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35.0
                        ),
                      ),
                      const Text(
                        "5",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          height: 2.2
                        ),
                      )
                    ],
                  ),
                  Text(
                    MultiLanguageString({
                      Constant.textEnUsLanguageKey: "${"From".tr} ${countryDeliveryReviewHeaderContent.reviewCount} ${"Review".tr}",
                      Constant.textInIdLanguageKey: "${"Dari".tr} ${countryDeliveryReviewHeaderContent.reviewCount} ${"Ulasan".tr}",
                    }).toStringNonNull,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}