import 'package:flutter/material.dart';

import 'modified_app_bar.dart';

class InfographicDetailAppBar extends ModifiedAppBar {
  InfographicDetailAppBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    PreferredSizeWidget? bottom,
  }) : super(
    key: key,
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading,
    bottom: bottom
  );

  @override
  BackgroundColorInterceptor get backgroundColorInterceptor {
    return (context, oldColor) => Colors.black.withOpacity(0.5);
  }
}