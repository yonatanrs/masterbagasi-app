import 'package:flutter/material.dart';

import 'list_item_controller_state.dart';

class TitleDescriptionAndContentListItemControllerState extends ListItemControllerState {
  String? title;
  String? description;
  ListItemControllerState? content;
  EdgeInsetsGeometry? padding;
  double? verticalSpace;

  TitleDescriptionAndContentListItemControllerState({
    this.title,
    this.description,
    this.content,
    this.padding,
    this.verticalSpace
  });
}