import 'package:flutter/material.dart';

import '../../../presentation/widget/titleanddescriptionitem/title_and_description_item.dart';
import 'list_item_controller_state.dart';

class TitleAndDescriptionListItemControllerState extends ListItemControllerState {
  String? title;
  String? description;
  EdgeInsetsGeometry? padding;
  double? verticalSpace;
  TitleAndDescriptionItemInterceptor? titleAndDescriptionItemInterceptor;

  TitleAndDescriptionListItemControllerState({
    this.title,
    this.description,
    this.padding,
    this.verticalSpace,
    this.titleAndDescriptionItemInterceptor
  });
}

class ShimmerTitleAndDescriptionListItemControllerState extends TitleAndDescriptionListItemControllerState {
  ShimmerTitleAndDescriptionListItemControllerState({
    String? title,
    String? description,
    EdgeInsetsGeometry? padding,
    double? verticalSpace
  }) : super(
    title: title,
    description: description,
    padding: padding,
    verticalSpace: verticalSpace
  );
}