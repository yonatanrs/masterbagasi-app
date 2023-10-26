import 'package:flutter/material.dart';

import 'price_widget.dart';

class ProductPriceWidget extends PriceWidget {
  const ProductPriceWidget({
    super.key,
    required super.price,
    super.discountPrice
  });

  @override
  Widget priceWidget(BuildContext context, Widget nonDiscountPriceWidget, Widget discountPriceWidget) {
    List<Widget> priceRowWidgetList = <Widget>[
      nonDiscountPriceWidget,
      Visibility(
        visible: discountPriceString != null,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: discountPriceWidget,
      )
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: priceRowWidgetList
    );
  }
}