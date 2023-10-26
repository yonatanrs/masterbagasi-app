import 'package:flutter/material.dart';

import '../../../presentation/widget/horizontal_justified_title_description_and_content.dart';
import 'widget_substitution_list_item_controller_state.dart';

class HorizontalJustifiedTitleDescriptionAndContentListItemControllerState extends WidgetSubstitutionListItemControllerState {
  String? title;
  HorizontalJustifiedTitleDescriptionAndContentWidgetInterceptor? titleWidgetInterceptor;
  String? description;
  HorizontalJustifiedTitleDescriptionAndContentWidgetInterceptor? descriptionWidgetInterceptor;
  String? content;
  HorizontalJustifiedTitleDescriptionAndContentWidgetInterceptor? contentWidgetInterceptor;
  bool hasTitle;
  bool hasDescription;
  bool hasContent;
  EdgeInsetsGeometry? padding;

  @override
  WidgetSubstitution get widgetSubstitution => (context, index) {
    Widget result = HorizontalJustifiedTitleDescriptionAndContent(
      title: title,
      titleWidgetInterceptor: titleWidgetInterceptor,
      description: description,
      descriptionWidgetInterceptor: descriptionWidgetInterceptor,
      content: content,
      contentWidgetInterceptor: contentWidgetInterceptor,
      hasTitle: hasTitle,
      hasDescription: hasDescription,
      hasContent: hasContent
    );
    return padding != null ? Padding(padding: padding!, child: result) : result;
  };

  HorizontalJustifiedTitleDescriptionAndContentListItemControllerState({
    this.title,
    this.titleWidgetInterceptor,
    this.description,
    this.descriptionWidgetInterceptor,
    this.content,
    this.contentWidgetInterceptor,
    this.hasTitle = true,
    this.hasDescription = true,
    this.hasContent = true,
    this.padding
  }) : super(widgetSubstitution: (context, index) => Container());
}