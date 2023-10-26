import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entity/cart/host_cart.dart';
import '../../misc/constant.dart';

class HostCartIndicator extends StatelessWidget {
  final HostCart hostCart;

  const HostCartIndicator({
    super.key,
    required this.hostCart
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Constant.colorDarkBlue),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text("@${hostCart.id}", style: const TextStyle(color: Colors.grey, fontSize: 18.0, fontWeight: FontWeight.bold))
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            color: Constant.colorDarkBlue,
            child: Text("Host".tr, style: const TextStyle(color: Colors.white, fontSize: 18.0)),
          )
        ],
      )
    );
  }
}