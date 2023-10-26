import 'package:flutter/material.dart';

import 'check_list_item.dart';

class BorderCheckListItem extends CheckListItem {
  const BorderCheckListItem({
    super.key,
    super.title,
    super.content,
    required super.value,
    required super.onChanged,
    super.toggleable = false,
    super.activeColor,
    super.activeStrokeColor,
    super.fillColor,
    super.strokeColor,
    super.focusColor,
    super.hoverColor,
    super.checkColor,
    super.overlayColor,
    super.splashRadius,
    super.shape,
    super.side,
    super.indentation = 0.0,
    super.reverse = false,
    super.spaceBetweenCheckListAndTitle = 10,
    super.spaceBetweenTitleAndContent = 10,
    super.showCheck = true,
    super.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.0)
      ),
      clipBehavior: Clip.antiAlias,
      child: super.build(context),
    );
  }
}