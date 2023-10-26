import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../domain/entity/coupon/coupon.dart';
import '../../../misc/constant.dart';
import '../../../misc/date_util.dart';
import '../modified_svg_picture.dart';
import '../tap_area.dart';

typedef OnSelectCoupon = void Function(Coupon);

abstract class CouponItem extends StatelessWidget {
  final Coupon coupon;
  final OnSelectCoupon? onSelectCoupon;
  final bool isSelected;

  const CouponItem({
    super.key,
    required this.coupon,
    required this.onSelectCoupon,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - (Constant.paddingListItem * 2);
    double height = width * 145 / 332;
    return TapArea(
      onTap: onSelectCoupon != null ? () => onSelectCoupon!(coupon) : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Constant.imageCoupon,
            ),
            fit: BoxFit.cover
          ),
        ),
        child: Stack(
          children: [
            if (isSelected)
              SizedBox(
                width: width * 30 / 100,
                height: height,
                child: Center(
                  child: ModifiedSvgPicture.asset(
                    Constant.vectorArrow,
                    height: 30,
                    color: Colors.white,
                  ),
                )
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.w, 30.0, 30.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Tooltip(
                    message: coupon.title,
                    child: Text(
                      coupon.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.white),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Text(
                      coupon.code,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14
                      )
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 30.w,
              bottom: height * 5 / 100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Constant.colorDarkBlue),
                ),
                clipBehavior: Clip.antiAlias,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                      color: Constant.colorDarkBlue,
                      child: Text("Valid Until".tr, style: const TextStyle(color: Colors.white, fontSize: 12.0)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                      color: Colors.white,
                      child: Text(
                        DateUtil.standardDateFormat7.format(coupon.activePeriodEnd),
                        style: TextStyle(
                          color: Constant.colorDarkBlue,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    )
                  ],
                )
              ),
            )
          ]
        ),
      ),
    );
  }
}