import 'package:flutter/material.dart';

import 'title_and_description_item.dart';

class ShimmerTitleAndDescriptionItem extends TitleAndDescriptionItem {
  const ShimmerTitleAndDescriptionItem({
    Key? key,
    required String? title,
    required String? description,
    required EdgeInsetsGeometry? padding,
    required double? verticalSpace
  }) : super(
    key: key,
    title: title,
    description: description,
    padding: padding,
    verticalSpace: verticalSpace
  );

  @override
  Widget titleWidget(BuildContext context, String title) {
    return Container(
      color: Colors.white,
      child: super.titleWidget(context, title)
    );
  }

  @override
  Widget descriptionWidget(BuildContext context, String description) {
    return Container(
      color: Colors.white,
      child: super.descriptionWidget(context, description)
    );
  }
}