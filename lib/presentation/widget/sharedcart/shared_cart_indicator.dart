import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../misc/constant.dart';
import '../modified_svg_picture.dart';

class SharedCartIndicator extends StatelessWidget {
  final VoidCallback? onTap;

  const SharedCartIndicator({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16.0)
          ),
          child: Row(
            children: [
              ModifiedSvgPicture.asset(Constant.vectorDiscount, color: Constant.colorDiscount),
              SizedBox(width: 2.w),
              Expanded(
                child: Text("Save more using shared cart".tr)
              ),
              SizedBox(width: 2.w),
              ModifiedSvgPicture.asset(
                Constant.vectorArrow,
                height: 10,
              ),
            ]
          )
        )
      )
    );
  }
}