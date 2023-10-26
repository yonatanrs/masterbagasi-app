import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

typedef HorizontalJustifiedTitleDescriptionAndContentWidgetInterceptor = Widget Function(String? text, Text widget);

class HorizontalJustifiedTitleDescriptionAndContent extends StatelessWidget {
  final String? title;
  final HorizontalJustifiedTitleDescriptionAndContentWidgetInterceptor? titleWidgetInterceptor;
  final String? description;
  final HorizontalJustifiedTitleDescriptionAndContentWidgetInterceptor? descriptionWidgetInterceptor;
  final String? content;
  final HorizontalJustifiedTitleDescriptionAndContentWidgetInterceptor? contentWidgetInterceptor;
  final bool hasTitle;
  final bool hasDescription;
  final bool hasContent;

  const HorizontalJustifiedTitleDescriptionAndContent({
    Key? key,
    this.title,
    this.titleWidgetInterceptor,
    this.description,
    this.descriptionWidgetInterceptor,
    this.content,
    this.contentWidgetInterceptor,
    this.hasTitle = true,
    this.hasDescription = true,
    this.hasContent = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text titleWidget = Text(title.toStringNonNull);
    Text descriptionWidget = Text(description.toStringNonNull);
    Text contentWidget = Text(content.toStringNonNull);
    return Row(
      children: [
        if (hasTitle || hasDescription)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasTitle) titleWidgetInterceptor != null ? titleWidgetInterceptor!(title, titleWidget) : titleWidget,
                if (hasDescription) descriptionWidgetInterceptor != null ? descriptionWidgetInterceptor!(description, descriptionWidget) : descriptionWidget
              ]
            )
          ),
        if (hasContent) contentWidgetInterceptor != null ? contentWidgetInterceptor!(content, contentWidget) : contentWidget
      ],
    );
  }
}