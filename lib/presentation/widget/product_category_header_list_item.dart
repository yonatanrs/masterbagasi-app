import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/product/productcategory/product_category.dart';
import '../../misc/aspect_ratio_value.dart';
import '../../misc/constant.dart';
import 'modifiedcachednetworkimage/brand_modified_cached_network_image.dart';
import 'modifiedcachednetworkimage/modified_cached_network_image.dart';

class ProductCategoryHeaderListItem extends StatelessWidget {
  final ProductCategory productCategory;

  const ProductCategoryHeaderListItem({super.key, required this.productCategory});

  @override
  Widget build(BuildContext context) {
    AspectRatioValue aspectRatioValue = Constant.aspectRatioValueBrandImage;
    double measuredWidth = Get.width - (Constant.paddingListItem * 2);
    double measuredHeight = measuredWidth * aspectRatioValue.height / aspectRatioValue.width;
    double profilePictureDimension = 20.w;
    double containerHeight = measuredHeight + (profilePictureDimension / 2);
    return SizedBox(
      width: double.infinity,
      height: containerHeight,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: aspectRatioValue.toDouble(),
            child: ClipRRect(
              child: ModifiedCachedNetworkImage(
                imageUrl: productCategory.bannerMobile.isNotEmptyString ? productCategory.bannerMobile! : productCategory.bannerDesktop.toEmptyStringNonNull,
              )
            )
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BrandModifiedCachedNetworkImage(
                    imageUrl: productCategory.icon.toEmptyStringNonNull,
                    dimension: profilePictureDimension,
                  ),
                  const SizedBox(width: 10),
                  Text(productCategory.name, style: const TextStyle(fontWeight: FontWeight.bold))
                ]
              )
            )
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: BrandModifiedCachedNetworkImage(
                imageUrl: productCategory.icon.toEmptyStringNonNull,
                dimension: profilePictureDimension,
              ),
            )
          ),
        ]
      )
    );
  }
}