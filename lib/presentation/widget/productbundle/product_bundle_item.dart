import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/entity/product/productbundle/product_bundle.dart';
import '../../../misc/constant.dart';
import '../../../misc/page_restoration_helper.dart';
import '../button/add_or_remove_wishlist_button.dart';
import '../button/custombutton/sized_outline_gradient_button.dart';
import '../modified_svg_picture.dart';
import '../modified_vertical_divider.dart';
import '../modifiedcachednetworkimage/product_bundle_modified_cached_network_image.dart';
import '../rating_indicator.dart';

typedef OnAddWishlistWithProductBundle = void Function(ProductBundle);
typedef OnRemoveWishlistWithProductBundle = void Function(ProductBundle);
typedef OnAddCartWithProductBundle = void Function(ProductBundle);
typedef OnRemoveCartWithProductBundle = void Function(ProductBundle);

abstract class ProductBundleItem extends StatelessWidget {
  final ProductBundle productBundle;
  final OnAddWishlistWithProductBundle? onAddWishlist;
  final OnRemoveWishlistWithProductBundle? onRemoveWishlist;
  final OnAddCartWithProductBundle? onAddCart;
  final OnRemoveCartWithProductBundle? onRemoveCart;

  const ProductBundleItem({
    super.key,
    required this.productBundle,
    this.onAddWishlist,
    this.onRemoveWishlist,
    this.onAddCart,
    this.onRemoveCart
  });

  @override
  Widget build(BuildContext context) {
    String soldCount = "No Sold Count".tr;
    bool comingSoon = productBundle.price.isZeroResult.isZero;
    BorderRadius borderRadius = BorderRadius.circular(16.0);
    void onWishlist(void Function(ProductBundle)? onWishlistCallback) {
      if (onWishlistCallback != null) {
        onWishlistCallback(productBundle);
      }
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AspectRatio(
        aspectRatio: Constant.aspectRatioValueProductBundleArea.toDouble(),
        child: Material(
          color: Colors.white,
          borderRadius: borderRadius,
          elevation: 3,
          child: InkWell(
            onTap: () => PageRestorationHelper.toProductBundleDetailPage(context, productBundle.id),
            borderRadius: borderRadius,
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: ProductBundleModifiedCachedNetworkImage(
                    imageUrl: productBundle.imageUrl,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productBundle.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  comingSoon ? "Coming Soon".tr : productBundle.price.toRupiah(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        soldCount,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w300
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    AddOrRemoveWishlistButton(
                                      onAddWishlist: onAddWishlist != null ? () => onWishlist(onAddWishlist) : null,
                                      onRemoveWishlist: onRemoveWishlist != null ? () => onWishlist(onRemoveWishlist) : null,
                                    ),
                                    SizedBox(width: 1.5.w),
                                    Expanded(
                                      child: SizedOutlineGradientButton(
                                        onPressed: !comingSoon ? (onAddCart != null ? () => onAddCart!(productBundle) : null) : null,
                                        text: "+ ${"Cart".tr}",
                                        outlineGradientButtonType: OutlineGradientButtonType.outline,
                                        outlineGradientButtonVariation: OutlineGradientButtonVariation.variation2,
                                        childInterceptor: (textStyle) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ModifiedSvgPicture.asset(
                                                Constant.vectorCart,
                                                color: Colors.grey.shade600,
                                              )
                                            ],
                                          );
                                        },
                                      )
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                )
              ]
            )
          )
        ),
      ),
    );
  }
}