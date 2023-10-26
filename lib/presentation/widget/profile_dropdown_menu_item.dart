import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../misc/constant.dart';
import 'icon_title_and_description_list_item.dart';
import 'modified_svg_picture.dart';
import 'dart:math' as math;

class ProfileDropdownMenuItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String? description;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final bool isExpand;

  const ProfileDropdownMenuItem({
    Key? key,
    this.onTap,
    required this.title,
    this.description,
    this.color,
    this.padding,
    required this.isExpand
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? EdgeInsets.all(4.w),
          child: IconTitleAndDescriptionListItem(
            title: title,
            description: description,
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
      ),
    );
  }
}