import 'package:flutter/material.dart';

import '../list_item_controller_state.dart';
import 'profile_menu_list_item_controller_state.dart';

class ProfileDropdownMenuListItemControllerState extends ListItemControllerState {
  void Function(BuildContext)? onTap;
  void Function() onUpdateState;
  String title;
  String? description;
  Color? color;
  List<ProfileMenuListItemControllerState> profileMenuListItemControllerStateList;
  bool isExpand;

  ProfileDropdownMenuListItemControllerState({
    this.onTap,
    required this.onUpdateState,
    required this.title,
    this.description,
    this.color,
    required this.isExpand,
    this.profileMenuListItemControllerStateList = const [],
  });
}