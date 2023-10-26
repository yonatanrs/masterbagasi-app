import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../domain/entity/product/product.dart';
import '../../misc/constant.dart';
import 'modifiedcachednetworkimage/modified_cached_network_image.dart';
import 'pricewidget/product_price_widget.dart';

class ProductDetailHeader extends BaseProductDetailHeader {
  const ProductDetailHeader({
    Key? key,
    required Product product,
  }) : super(
    key: key,
    product: product,
  );
}

class ShimmerProductDetailHeader extends BaseProductDetailHeader {
  const ShimmerProductDetailHeader({Key? key}) : super(key: key, isLoading: true);
}

abstract class BaseProductDetailHeader extends StatelessWidget {
  final Product? product;
  final bool isLoading;

  const BaseProductDetailHeader({
    Key? key,
    this.product,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isProductNotNull = product != null;
    Color? textBackgroundColor = isLoading ? Colors.grey : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: ClipRRect(
            child: ModifiedCachedNetworkImage(
              imageUrl: isProductNotNull ? product!.imageUrl.toEmptyStringNonNull : "",
            )
          )
        ),
        Padding(
          padding: EdgeInsets.all(Constant.paddingListItem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isProductNotNull ? product!.name.toStringNonNull : (isLoading ? "Dummy Title" : ""),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  backgroundColor: textBackgroundColor
                )
              ),
              if (isProductNotNull)
                ...<Widget>[
                  SizedBox(height: 1.h),
                  ProductPriceWidget(
                    price: product!.price,
                    discountPrice: product!.discountPrice
                  )
                ]
            ],
          )
        )
      ]
    );
  }
}