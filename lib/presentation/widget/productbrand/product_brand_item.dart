import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/entity/product/productbrand/product_brand.dart';
import '../../../misc/constant.dart';
import '../../../misc/page_restoration_helper.dart';
import '../../page/product_entry_page.dart';
import '../modified_divider.dart';
import '../modifiedcachednetworkimage/product_modified_cached_network_image.dart';

abstract class ProductBrandItem extends StatelessWidget {
  final ProductBrand productBrand;

  @protected
  double? get itemWidth;

  const ProductBrandItem({
    Key? key,
    required this.productBrand
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = const BorderRadius.only(
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0)
    );
    return SizedBox(
      width: itemWidth,
      child: Padding(
        // Use padding widget for avoiding shadow elevation overlap.
        padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
        child: Material(
          color: Colors.white,
          borderRadius: borderRadius,
          elevation: 3,
          child: InkWell(
            onTap: () => PageRestorationHelper.toProductEntryPage(
              context,
              ProductEntryPageParameter(
                productEntryParameterMap: {
                  "brand_id": productBrand.id,
                  "brand": productBrand.slug
                }
              )
            ),
            borderRadius: borderRadius,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: borderRadius
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      child: ProductModifiedCachedNetworkImage(
                        imageUrl: productBrand.icon.toEmptyStringNonNull,
                      )
                    )
                  ),
                  ModifiedDivider(
                    lineHeight: 3.5,
                    lineColor: Constant.colorGrey5
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Tooltip(
                          message: productBrand.name.toStringNonNull,
                          child: Text(
                            productBrand.name.toStringNonNull,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            )
          )
        ),
      )
    );
  }
}