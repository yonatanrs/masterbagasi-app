import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../misc/constant.dart';
import '../modified_svg_picture.dart';

class WaitingForPaymentOrderItem extends StatelessWidget {
  final int waitingForPaymentOrderCount;
  final void Function()? onTap;

  const WaitingForPaymentOrderItem({
    super.key,
    required this.waitingForPaymentOrderCount,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        borderRadius: BorderRadius.circular(16.0),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16.0)
            ),
            child: Row(
              children: [
                ModifiedSvgPicture.asset(Constant.vectorWaitingForPaymentOrder, overrideDefaultColorWithSingleColor: false),
                const SizedBox(width: 10),
                Text("${"Waiting For Payment".tr} ($waitingForPaymentOrderCount)", style: const TextStyle()),
                const Spacer(),
                ModifiedSvgPicture.asset(
                  Constant.vectorArrow,
                  height: 12,
                  color: Colors.black,
                ),
              ]
            )
          )
        )
      )
    );
  }
}