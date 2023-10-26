import '../../../presentation/widget/titleanddescriptionitem/title_and_description_item.dart';
import 'list_item_controller_state.dart';

class IconTitleAndDescriptionListItemControllerState extends ListItemControllerState {
  String? title;
  String? description;
  TitleAndDescriptionItemInterceptor? titleAndDescriptionItemInterceptor;
  ListItemControllerState? iconListItemControllerState;
  double? space;
  double? verticalSpace;

  IconTitleAndDescriptionListItemControllerState({
    this.title,
    this.description,
    this.titleAndDescriptionItemInterceptor,
    this.iconListItemControllerState,
    this.space,
    this.verticalSpace
  });
}