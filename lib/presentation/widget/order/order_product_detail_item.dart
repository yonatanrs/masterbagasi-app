import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';

import '../../../domain/entity/order/order_product_detail.dart';
import '../../../domain/entity/order/support_order_product.dart';
import '../modifiedcachednetworkimage/product_modified_cached_network_image.dart';

class OrderProductDetailItem extends StatelessWidget {
  final OrderProductDetail orderProductDetail;

  const OrderProductDetailItem({
    super.key,
    required this.orderProductDetail
  });

  @override
  Widget build(BuildContext context) {
    SupportOrderProduct supportOrderProduct = orderProductDetail.supportOrderProduct;
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              child: ProductModifiedCachedNetworkImage(
                imageUrl: supportOrderProduct.orderImageUrl,
              )
            )
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                supportOrderProduct.orderTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
                )
              ),
              const SizedBox(height: 3),
              Text(
                supportOrderProduct.orderPrice.toRupiah()
              ),
              const SizedBox(height: 3),
              Text(
                "${orderProductDetail.quantity} ${"Item".tr}",
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis
                )
              )
            ]
          ),
        ),
      ]
    );
  }
}