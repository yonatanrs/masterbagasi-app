import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../../domain/entity/product/productbrand/product_brand.dart';
import '../../../../misc/page_restoration_helper.dart';
import '../../../page/product_entry_page.dart';
import '../../modifiedcachednetworkimage/circle_product_modified_cached_network_image.dart';
import '../../tap_area.dart';

abstract class CircleProductBrandItem extends StatelessWidget {
  final ProductBrand productBrand;

  @protected
  double? get itemWidth;

  const CircleProductBrandItem({
    Key? key,
    required this.productBrand
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
              "brand_id": productBrand.id,
              "brand": productBrand.slug
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
                  productImageUrl: productBrand.icon.toEmptyStringNonNull,
                  dimension: 20,
                )
              )
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Text(
                productBrand.name,
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