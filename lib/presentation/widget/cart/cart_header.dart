import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../check_list_item.dart';

class CartHeader extends StatelessWidget {
  final bool isSelected;
  final void Function() onChangeSelected;

  const CartHeader({
    Key? key,
    required this.isSelected,
    required this.onChangeSelected
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckListItem(
      value: isSelected,
      title: Text("Select All".tr),
      onChanged: (bool? value) => onChangeSelected(),
      reverse: true,
      spaceBetweenCheckListAndTitle: 4.w,
      spaceBetweenTitleAndContent: 4.w,
    );
  }
}