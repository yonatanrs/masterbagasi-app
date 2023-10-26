import 'package:flutter/widgets.dart';

import '../../../misc/constant.dart';
import '../titleanddescriptionitem/title_and_description_item.dart';

class TitleDescriptionAndContentItem extends StatelessWidget {
  final String? title;
  final String? description;
  final WidgetBuilder? builder;
  final double? verticalSpace;

  const TitleDescriptionAndContentItem({
    Key? key,
    required this.title,
    required this.description,
    required this.builder,
    required this.verticalSpace
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleAndDescriptionItem(
          padding: EdgeInsets.only(left: Constant.paddingListItem, top: Constant.paddingListItem, right: Constant.paddingListItem, bottom: Constant.paddingListItem),
          title: title,
          description: description,
          verticalSpace: verticalSpace,
        ),
        if (builder != null) builder!(context)
      ]
    );
  }
}