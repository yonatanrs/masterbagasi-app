import 'package:flutter/material.dart';

import '../../../../presentation/widget/titleanddescriptionitem/title_and_description_item.dart';
import '../list_item_controller_state.dart';

class ProfileMenuListItemControllerState extends ListItemControllerState {
  void Function(BuildContext)? onTap;
  WidgetBuilder icon;
  String title;
  TitleInterceptor? titleInterceptor;
  String? description;
  DescriptionInterceptor? descriptionInterceptor;
  Color? color;

  ProfileMenuListItemControllerState({
    required this.onTap,
    required this.icon,
    required this.title,
    this.titleInterceptor,
    this.description,
    this.descriptionInterceptor,
    this.color
  });
}