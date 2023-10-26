import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../misc/constant.dart';
import '../../../misc/inputdecoration/default_input_decoration.dart';
import '../../../misc/page_restoration_helper.dart';
import '../../page/getx_page.dart';
//import '../../page/search/search_page.dart';
import 'modified_app_bar.dart';
import '../modified_text_field.dart';

typedef ActionTitleBuilder = Widget Function(BuildContext context);
typedef TextFieldBuilder = Widget Function(BuildContext context);
typedef OnSearch = void Function(String search);

abstract class SearchAppBar extends ModifiedAppBar {
  final VoidCallback? onSearchTextFieldTapped;
  final OnSearch? onSearch;
  final TextEditingController? searchTextEditingController;
  final double value;
  final FocusNode? searchFocusNode;
  final bool isSearchText;

  SearchAppBar({
    Key? key,
    Widget? leading,
    bool automaticallyImplyLeading = true,
    PreferredSizeWidget? bottom,
    this.value = 1.0,
    this.onSearchTextFieldTapped,
    this.onSearch,
    this.searchTextEditingController,
    this.searchFocusNode,
    this.isSearchText = false
  }) : super(
    key: key,
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading,
    bottom: bottom
  );

  double get searchTextFieldHeight => 40.0;

  @override
  BackgroundColorInterceptor get backgroundColorInterceptor {
    return (context, oldColor) => oldColor?.withOpacity(value);
  }

  ActionTitleBuilder? get actionTitleBuilder => null;

  TextFieldBuilder get textFieldBuilder {
    return (context) {
      Widget textField = ModifiedTextField(
        isError: false,
        onEditingComplete: onSearch != null ? () {
          if (searchTextEditingController != null) {
            onSearch!(searchTextEditingController!.text);
          }
        } : null,
        textInputAction: TextInputAction.done,
        controller: searchTextEditingController,
        focusNode: searchFocusNode,
        decoration: searchTextFieldStyle(
          context, DefaultInputDecoration(
            hintText: "Search in Masterbagasi".tr,
            filled: true,
            fillColor: Colors.transparent,
            prefixIcon: const Icon(Icons.search),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
          )
        )
      );
      return !isSearchText ? IgnorePointer(
        child: ExcludeFocus(
          child: textField
        )
      ) : textField;
    };
  }

  @override
  TitleInterceptor? get titleInterceptor {
    return (context, oldTitle) => Row(
      children: [
        Expanded(
          child: SizedBox(
            height: searchTextFieldHeight,
            child: Material(
              borderRadius: Constant.inputBorderRadius,
              child: Builder(
                builder: (context) {
                  if (isSearchText) {
                    return textFieldBuilder(context);
                  }
                  VoidCallback? effectiveOnSearchTextFieldTapped;
                  if (onSearchTextFieldTapped != null) {
                    effectiveOnSearchTextFieldTapped = onSearchTextFieldTapped!;
                  } else {
                    effectiveOnSearchTextFieldTapped = () {
                      PageRestorationHelper.toSearchPage(context);
                    };
                  }
                  return InkWell(
                    borderRadius: Constant.inputBorderRadius,
                    onTap: effectiveOnSearchTextFieldTapped,
                    child: textFieldBuilder(context)
                  );
                },
              )
            )
          )
        ),
        if (actionTitleBuilder != null) actionTitleBuilder!(context),
      ]
    );
  }

  @override
  SystemOverlayStyleInterceptor get systemOverlayStyleInterceptor {
    return (context, oldSystemUiOverlayStyle) => value > 0.5 ? null : SystemUiOverlayStyle.light;
  }

  InputDecoration searchTextFieldStyle(BuildContext context, InputDecoration decoration) {
    final ThemeData themeData = Theme.of(context);
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle style = TextStyle(
      color: decoration.enabled ? themeData.hintColor : themeData.disabledColor,
    );
    if (style.inherit) {
      style = defaultTextStyle.style.merge(style);
    }
    if (MediaQuery.boldTextOverride(context)) {
      style = style.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    return decoration.copyWith(hintStyle: style);
  }
}