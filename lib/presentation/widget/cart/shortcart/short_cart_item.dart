import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';

import '../../../../domain/entity/cart/cart.dart';
import '../../modifiedcachednetworkimage/product_modified_cached_network_image.dart';

typedef OnSelectCart = void Function(Cart);

abstract class ShortCartItem extends StatelessWidget {
  final Cart cart;
  final OnSelectCart? onSelectCart;

  @protected
  double? get itemWidth;

  @protected
  double? get itemHeight;

  const ShortCartItem({
    super.key,
    required this.cart,
    this.onSelectCart
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = const BorderRadius.only(
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0)
    );
    return SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: Padding(
        // Use padding widget for avoiding shadow elevation overlap.
        padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
        child: Material(
          color: Colors.white,
          borderRadius: borderRadius,
          elevation: 3,
          child: InkWell(
            onTap: onSelectCart != null ? () => onSelectCart!(cart) : null,
            borderRadius: borderRadius,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: borderRadius
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: itemHeight,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: ClipRRect(
                        child: ProductModifiedCachedNetworkImage(
                          imageUrl: cart.supportCart.cartImageUrl,
                        )
                      )
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Tooltip(
                                message: cart.supportCart.cartTitle,
                                child: Text(
                                  cart.supportCart.cartTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                cart.supportCart.cartPrice.toRupiah(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  )
                ]
              )
            )
          )
        ),
      )
    );
  }
}