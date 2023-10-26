import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../misc/constant.dart';
import '../../../misc/inputdecoration/default_input_decoration.dart';
import '../../../misc/page_restoration_helper.dart';
import '../modified_text_field.dart';
import '../tap_area.dart';
import 'search_app_bar.dart';

class MainMenuSearchAppBar extends SearchAppBar {
  MainMenuSearchAppBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    PreferredSizeWidget? bottom,
    double value = 1.0,
    VoidCallback? onSearchTextFieldTapped
  }) : super(
    key: key,
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading,
    bottom: bottom,
    value: value,
    onSearchTextFieldTapped: onSearchTextFieldTapped
  );

  @override
  TextFieldBuilder get textFieldBuilder {
    return (context) => Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade600),
          const SizedBox(width: 10),
          Text("Search in Masterbagasi".tr, style: TextStyle(color: Colors.grey.shade600)),
          const Spacer(),
          TapArea(
            onTap: () => PageRestorationHelper.toNotificationPage(context),
            child: SvgPicture.asset(
              Constant.vectorNotification,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 10),
          SvgPicture.asset(
            Constant.vectorInbox,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 10),
          TapArea(
            onTap: () {
              PageRestorationHelper.toCartPage(context);
            },
            child: SvgPicture.asset(
              Constant.vectorCart,
              color: Colors.grey.shade600,
            ),
          ),
        ]
      )
    );
  }
}