import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'titleanddescriptionitem/title_and_description_item.dart';

class IconTitleAndDescriptionListItem extends StatelessWidget {
  final String? title;
  final String? description;
  final TitleInterceptor? titleInterceptor;
  final DescriptionInterceptor? descriptionInterceptor;
  final TitleAndDescriptionItemInterceptor? titleAndDescriptionItemInterceptor;
  final Widget? icon;
  final double? space;
  final double? verticalSpace;
  final CrossAxisAlignment rowCrossAxisAlignment;

  const IconTitleAndDescriptionListItem({
    Key? key,
    required this.title,
    required this.description,
    this.titleInterceptor,
    this.descriptionInterceptor,
    this.titleAndDescriptionItemInterceptor,
    required this.icon,
    this.space,
    this.verticalSpace,
    this.rowCrossAxisAlignment = CrossAxisAlignment.center
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    double effectiveSpace = space ?? (1.0).w;
    return Row(
      crossAxisAlignment: rowCrossAxisAlignment,
      children: [
        if (icon != null) ...<Widget>[
          icon!,
          SizedBox(width: effectiveSpace),
        ],
        Expanded(
          child: TitleAndDescriptionItem(
            padding: const EdgeInsets.all(0),
            title: title,
            description: description,
            titleInterceptor: titleInterceptor,
            descriptionInterceptor: descriptionInterceptor,
            titleAndDescriptionItemInterceptor: titleAndDescriptionItemInterceptor,
            verticalSpace: verticalSpace,
          ),
        )
      ]
    );
  }
}