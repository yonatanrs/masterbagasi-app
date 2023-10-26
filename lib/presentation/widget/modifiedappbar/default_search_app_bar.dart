import 'package:flutter/material.dart';

import 'search_app_bar.dart';

class DefaultSearchAppBar extends SearchAppBar {
  DefaultSearchAppBar({
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
}