import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:masterbagasi/misc/ext/number_ext.dart';

import '../../../misc/constant.dart';

abstract class PriceWidget extends StatelessWidget {
  final double price;
  final double? discountPrice;

  const PriceWidget({
    super.key,
    required this.price,
    this.discountPrice
  });

  @protected
  String get priceString => _priceString(price);

  @protected
  String? get discountPriceString {
    return discountPrice != null ? (discountPrice == price ? null : _priceString(discountPrice!)) : null;
  }

  Widget _discountPriceWidget(BuildContext context) {
    return Text(
      priceString,
      style: TextStyle(
        color: Constant.colorProductItemDiscountOrNormal,
        decoration: TextDecoration.lineThrough
      )
    );
  }

  Widget _nonDiscountPriceWidget(BuildContext context) {
    return Text(
      discountPriceString != null ? discountPriceString! : priceString,
      style: discountPriceString != null ? Theme.of(context).textTheme.labelLarge?.merge(
        TextStyle(
          color: Theme.of(context).colorScheme.primary
        )
      ) : TextStyle(
        color: Constant.colorProductItemDiscountOrNormal
      )
    );
  }

  String _priceString(double price) {
    if (price == 0.0) {
      return "Free".tr;
    } else {
      return price.toRupiah();
    }
  }

  Widget priceWidget(BuildContext context, Widget nonDiscountPriceWidget, Widget discountPriceWidget);

  @override
  Widget build(BuildContext context) {
    return priceWidget(context, _nonDiscountPriceWidget(context), _discountPriceWidget(context));
  }
}