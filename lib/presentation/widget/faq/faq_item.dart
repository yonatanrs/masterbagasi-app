import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

import '../../../domain/entity/faq/faq.dart';
import '../../../misc/constant.dart';
import '../icon_title_and_description_list_item.dart';
import '../modified_svg_picture.dart';
import '../tap_area.dart';

class FaqItem extends StatelessWidget {
  final Faq faq;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool isExpand;

  const FaqItem({
    super.key,
    required this.faq,
    this.onTap,
    this.padding,
    required this.isExpand
  });

  @override
  Widget build(BuildContext context) {
    return TapArea(
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.all(4.w),
        child: IconTitleAndDescriptionListItem(
          title: faq.title,
          description: null,
          titleInterceptor: (title, titleTextStyle) {
            return Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold)
            );
          },
          descriptionInterceptor: (description, descriptionTextStyle) {
            return Text(
              description,
              style: const TextStyle(color: Colors.grey)
            );
          },
          titleAndDescriptionItemInterceptor: (padding, title, titleWidget, description, descriptionWidget, titleAndDescriptionWidget, titleAndDescriptionWidgetList) {
            return Row(
              children: [
                Expanded(
                  child: titleAndDescriptionWidget
                ),
                const SizedBox(width: 10),
                Transform.rotate(
                  angle: !isExpand ? math.pi / 2 : -math.pi / 2,
                  child: SizedBox(
                    child: ModifiedSvgPicture.asset(
                      Constant.vectorArrow,
                      width: 8.0,
                    ),
                  )
                ),
              ],
            );
          },
          space: 4.w,
          verticalSpace: (0.5).h,
          icon: null,
        )
      ),
    );
  }
}