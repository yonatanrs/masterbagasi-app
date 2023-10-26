import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../../domain/entity/product/productcategory/product_category.dart';
import '../../../../misc/page_restoration_helper.dart';
import '../../../page/product_entry_page.dart';
import '../../modifiedcachednetworkimage/circle_product_modified_cached_network_image.dart';
import '../../tap_area.dart';

abstract class CircleProductCategoryItem extends StatelessWidget {
  final ProductCategory productCategory;

  @protected
  double? get itemWidth;

  const CircleProductCategoryItem({
    Key? key,
    required this.productCategory
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth,
      child: TapArea(
        onTap: () => PageRestorationHelper.toProductEntryPage(
          context,
          ProductEntryPageParameter(
            productEntryParameterMap: {
              "category": productCategory.slug
            }
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: ClipRRect(
                child: CircleProductModifiedCachedNetworkImage(
                  productImageUrl: productCategory.icon.toEmptyStringNonNull,
                  dimension: 50,
                  isClipped: false,
                )
              )
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey)
              ),
              child: Text(
                productCategory.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            )
          ],
        )
      )
    );
  }
}