import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:sizer/sizer.dart';

import '../../misc/constant.dart';

enum PromptIndicatorType {
  horizontal, vertical
}

class PromptIndicator extends StatelessWidget {
  final Image? image;
  final String? promptTitleText;
  final String? promptText;
  final String? buttonText;
  final VoidCallback? onPressed;
  final PromptIndicatorType promptIndicatorType;

  const PromptIndicator({
    Key? key,
    this.image,
    this.promptTitleText,
    this.promptText,
    this.buttonText,
    this.onPressed,
    this.promptIndicatorType = PromptIndicatorType.vertical
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    if (promptIndicatorType == PromptIndicatorType.vertical) {
      return _VerticalPromptIndicator(
        image: image,
        promptTitleText: promptTitleText,
        promptText: promptText,
        buttonText: buttonText,
        onPressed: onPressed
      );
    } else {
      return _HorizontalPromptIndicator(
        image: image,
        promptTitleText: promptTitleText,
        promptText: promptText,
        buttonText: buttonText,
        onPressed: onPressed
      );
    }
  }
}

class _VerticalPromptIndicator extends StatelessWidget {
  final Image? image;
  final String? promptTitleText;
  final String? promptText;
  final String? buttonText;
  final VoidCallback? onPressed;

  const _VerticalPromptIndicator({
    Key? key,
    this.image,
    this.promptTitleText,
    this.promptText,
    this.buttonText,
    this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> columnWidget = <Widget>[
      SizedBox(
        height: 50.w,
        width: double.infinity,
        child: FittedBox(
          child: image
        )
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              promptTitleText ?? "",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center
            ),
            if (!promptText.isEmptyString)
              ...[
                const SizedBox(height: 4.0),
                Text(promptText ?? "", style: const TextStyle(color: Colors.black), textAlign: TextAlign.center)
              ]
          ]
        ),
      ),
    ];
    if (onPressed != null) {
      columnWidget.addAll(
        <Widget>[
          SizedBox(height: 1.h),
          SizedBox(
            width: 50.w,
            child: TextButton(
              onPressed: onPressed,
              child: Text(buttonText.toEmptyStringNonNull),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
            )
          ),
        ]
      );
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: columnWidget,
      )
    );
  }
}

class _HorizontalPromptIndicator extends StatelessWidget {
  final Image? image;
  final String? promptTitleText;
  final String? promptText;
  final String? buttonText;
  final VoidCallback? onPressed;

  const _HorizontalPromptIndicator({
    Key? key,
    this.image,
    this.promptTitleText,
    this.promptText,
    this.buttonText,
    this.onPressed
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidget = <Widget>[
      SizedBox(
        height: 55,
        child: FittedBox(
          child: image
        )
      ),
      SizedBox(width: 2.w),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              promptTitleText ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.start
            ),
            if (!promptText.isEmptyString)
              ...[
                const SizedBox(height: 4.0),
                Text(promptText ?? "", style: const TextStyle(color: Colors.black), textAlign: TextAlign.start)
              ]
          ]
        ),
      ),
    ];
    if (onPressed != null) {
      rowWidget.addAll(
        <Widget>[
          SizedBox(width: 2.w),
          SizedBox(
            child: TextButton(
              onPressed: onPressed,
              child: Text(buttonText.toEmptyStringNonNull),
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Theme.of(context).colorScheme.primary,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap
              ),
            )
          ),
        ]
      );
    }
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constant.paddingListItem, vertical: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowWidget,
        ),
      )
    );
  }
}