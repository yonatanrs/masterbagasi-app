import 'package:flutter/material.dart';

import '../../tab_data.dart';
import 'list_item_controller_state.dart';

class TabBarListItemControllerState extends ListItemControllerState {
  List<TabData> tabDataList;
  TabController tabController;

  TabBarListItemControllerState({
    required this.tabDataList,
    required this.tabController
  });
}