import '../../../presentation/widget/colorful_chip_tab_bar.dart';
import 'list_item_controller_state.dart';

class ColorfulChipTabBarListItemControllerState extends ListItemControllerState {
  final List<ColorfulChipTabBarData> colorfulChipTabBarDataList;
  final ColorfulChipTabBarController colorfulChipTabBarController;
  final bool isWrap;

  ColorfulChipTabBarListItemControllerState({
    required this.colorfulChipTabBarDataList,
    required this.colorfulChipTabBarController,
    this.isWrap = true
  });
}

class ShimmerColorfulChipTabBarListItemControllerState extends ListItemControllerState {}