import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/product/productbrand/product_brand.dart';
import '../../misc/aspect_ratio_value.dart';
import '../../misc/constant.dart';
import 'button/custombutton/sized_outline_gradient_button.dart';
import 'modifiedcachednetworkimage/brand_modified_cached_network_image.dart';
import 'modifiedcachednetworkimage/modified_cached_network_image.dart';
import 'profile_picture_cache_network_image.dart';
import 'tap_area.dart';

class ProductDetailBrandListItem extends StatelessWidget {
  final ProductBrand productBrand;
  final void Function(ProductBrand)? onTapProductBrand;
  final void Function(ProductBrand)? onAddToFavoriteProductBrand;
  final void Function(ProductBrand)? onRemoveFromFavoriteProductBrand;

  const ProductDetailBrandListItem({
    super.key,
    required this.productBrand,
    this.onTapProductBrand,
    required this.onAddToFavoriteProductBrand,
    required this.onRemoveFromFavoriteProductBrand
  });

  @override
  Widget build(BuildContext context) {
    AspectRatioValue aspectRatioValue = Constant.aspectRatioValueBrandImage;
    double measuredWidth = Get.width - (Constant.paddingListItem * 2);
    double measuredHeight = measuredWidth * aspectRatioValue.height / aspectRatioValue.width;
    double profilePictureDimension = 20.w;
    double containerHeight = measuredHeight + (profilePictureDimension / 2) + 15;
    return SizedBox(
      width: double.infinity,
      height: containerHeight,
      child: TapArea(
        onTap: onTapProductBrand != null ? () => onTapProductBrand!(productBrand) : null,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: aspectRatioValue.toDouble(),
              child: ClipRRect(
                child: ModifiedCachedNetworkImage(
                  imageUrl: productBrand.bannerMobile.isNotEmptyString ? productBrand.bannerMobile! : productBrand.bannerDesktop.toEmptyStringNonNull,
                )
              )
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BrandModifiedCachedNetworkImage(
                      imageUrl: productBrand.icon.toEmptyStringNonNull,
                      dimension: profilePictureDimension,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          productBrand.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedOutlineGradientButton(
                          onPressed: () {
                            if (onAddToFavoriteProductBrand != null) {
                              return onAddToFavoriteProductBrand!(productBrand);
                            } else if (onRemoveFromFavoriteProductBrand != null) {
                              return onRemoveFromFavoriteProductBrand!(productBrand);
                            }
                          },
                          text: onAddToFavoriteProductBrand != null ? "Favoritkan" : "Hapus Dari Favorit",
                          outlineGradientButtonType: OutlineGradientButtonType.solid,
                          outlineGradientButtonVariation: OutlineGradientButtonVariation.variation1,
                        ),
                      ]
                    )
                  ]
                )
              )
            ),
          ]
        ),
      )
    );
  }
}