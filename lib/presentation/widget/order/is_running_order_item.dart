import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../misc/constant.dart';
import '../modified_svg_picture.dart';

class IsRunningOrderItem extends StatelessWidget {
  final int isRunningOrderCount;
  final void Function()? onTap;

  const IsRunningOrderItem({
    super.key,
    required this.isRunningOrderCount,
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
                ModifiedSvgPicture.asset(Constant.vectorIsRunningOrder, overrideDefaultColorWithSingleColor: false),
                const SizedBox(width: 10),
                Text("${"Is Running".tr} ($isRunningOrderCount)", style: const TextStyle()),
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