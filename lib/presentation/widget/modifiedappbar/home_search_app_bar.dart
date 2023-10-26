import 'package:flutter/material.dart';
import '../../../misc/errorprovider/error_provider.dart';
import 'search_app_bar.dart';

class HomeSearchAppBar extends SearchAppBar {
  HomeSearchAppBar({
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