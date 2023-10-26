import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

typedef HorizontalJustifiedTitleAndDescriptionWidgetInterceptor = Widget Function(String? text, Text widget);

class HorizontalJustifiedTitleAndDescription extends StatelessWidget {
  final String? title;
  final HorizontalJustifiedTitleAndDescriptionWidgetInterceptor? titleWidgetInterceptor;
  final String? description;
  final HorizontalJustifiedTitleAndDescriptionWidgetInterceptor? descriptionWidgetInterceptor;
  final bool hasTitle;
  final bool hasDescription;

  const HorizontalJustifiedTitleAndDescription({
    Key? key,
    this.title,
    this.titleWidgetInterceptor,
    this.description,
    this.descriptionWidgetInterceptor,
    this.hasTitle = true,
    this.hasDescription = true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text titleWidget = Text(title.toStringNonNull);
    Text descriptionWidget = Text(description.toStringNonNull);
    return Row(
      children: [
        if (hasTitle) Expanded(child: titleWidgetInterceptor != null ? titleWidgetInterceptor!(title, titleWidget) : titleWidget),
        if (hasDescription) descriptionWidgetInterceptor != null ? descriptionWidgetInterceptor!(description, descriptionWidget) : descriptionWidget
      ],
    );
  }
}