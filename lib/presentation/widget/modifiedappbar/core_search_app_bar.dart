import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../misc/constant.dart';
import '../../../misc/page_restoration_helper.dart';
import 'modified_app_bar.dart';
import 'search_app_bar.dart';

class CoreSearchAppBar extends SearchAppBar {
  final bool readOnly;
  final bool showFilterIconButton;
  final VoidCallback? onTapSearchFilterIcon;

  CoreSearchAppBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    PreferredSizeWidget? bottom,
    double value = 1.0,
    VoidCallback? onSearchTextFieldTapped,
    OnSearch? onSearch,
    TextEditingController? searchTextEditingController,
    this.readOnly = true,
    required this.showFilterIconButton,
    this.onTapSearchFilterIcon,
    FocusNode? searchFocusNode
  }) : super(
    key: key,
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading,
    bottom: bottom,
    value: value,
    onSearchTextFieldTapped: onSearchTextFieldTapped,
    onSearch: onSearch,
    searchTextEditingController: searchTextEditingController,
    searchFocusNode: searchFocusNode,
    isSearchText: true
  );

  @override
  ActionTitleBuilder? get actionTitleBuilder {
    if (!showFilterIconButton) {
      return null;
    }
    return (context) => Row(
      children: [
        SizedBox(width: 2.w),
        IconButton(
          onPressed: onTapSearchFilterIcon ?? () {}, //() => PageRestorationHelper.toSearchFilterPage(context),
          icon: SvgPicture.asset(
            "", //Constant.vectorFilter,
            color: Color.lerp(Colors.white, Theme.of(context).colorScheme.primary, value),
            width: 10.w
          )
        )
      ]
    );
  }

  @override
  TitleInterceptor? get titleInterceptor {
    if (!readOnly) {
      return super.titleInterceptor;
    }
    return (context, oldTitle) {
      return IgnorePointer(
        child: ExcludeFocus(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: searchTextFieldHeight,
                  child: textFieldBuilder(context)
                )
              ),
              if (actionTitleBuilder != null) actionTitleBuilder!(context),
            ]
          )
        )
      );
    };
  }
}