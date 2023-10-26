import 'package:flutter/material.dart';

import '../../../presentation/widget/horizontal_justified_title_and_description.dart';
import 'widget_substitution_list_item_controller_state.dart';

class HorizontalJustifiedTitleAndDescriptionListItemControllerState extends WidgetSubstitutionListItemControllerState {
  String? title;
  HorizontalJustifiedTitleAndDescriptionWidgetInterceptor? titleWidgetInterceptor;
  String? description;
  HorizontalJustifiedTitleAndDescriptionWidgetInterceptor? descriptionWidgetInterceptor;
  bool hasTitle;
  bool hasDescription;
  EdgeInsetsGeometry? padding;

  @override
  WidgetSubstitution get widgetSubstitution => (context, index) {
    Widget result = HorizontalJustifiedTitleAndDescription(
      title: title,
      titleWidgetInterceptor: titleWidgetInterceptor,
      description: description,
      descriptionWidgetInterceptor: descriptionWidgetInterceptor,
      hasTitle: hasTitle,
      hasDescription: hasDescription,
    );
    return padding != null ? Padding(padding: padding!, child: result) : result;
  };

  HorizontalJustifiedTitleAndDescriptionListItemControllerState({
    this.title,
    this.titleWidgetInterceptor,
    this.description,
    this.descriptionWidgetInterceptor,
    this.hasTitle = true,
    this.hasDescription = true,
    this.padding
  }) : super(widgetSubstitution: (context, index) => Container());
}