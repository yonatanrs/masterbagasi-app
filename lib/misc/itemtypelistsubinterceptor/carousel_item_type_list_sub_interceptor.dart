import '../controllerstate/listitemcontrollerstate/carousel_list_item_controller_state.dart';
import '../controllerstate/listitemcontrollerstate/list_item_controller_state.dart';
import '../itemtypelistinterceptor/itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';
import 'item_type_list_sub_interceptor.dart';

class CarouselItemTypeListSubInterceptor extends ItemTypeListSubInterceptor<ListItemControllerState> {
  ListItemControllerStateItemTypeInterceptorChecker listItemControllerStateItemTypeInterceptorChecker;

  CarouselItemTypeListSubInterceptor({
    required this.listItemControllerStateItemTypeInterceptorChecker
  });

  @override
  bool intercept(
    int i,
    ListItemControllerStateWrapper oldItemTypeWrapper,
    List<ListItemControllerState> oldItemTypeList,
    List<ListItemControllerState> newItemTypeList
  ) {
    ListItemControllerState oldItemType = oldItemTypeWrapper.listItemControllerState;
    if (oldItemType is CarouselListItemControllerState) {
      int j = 0;
      List<ListItemControllerState> columnChildListItemControllerState = oldItemType.itemListItemControllerState;
      List<ListItemControllerState> newColumnChildListItemControllerState = [];
      while (j < columnChildListItemControllerState.length) {
        ListItemControllerState listItemControllerState = columnChildListItemControllerState[j];
        listItemControllerStateItemTypeInterceptorChecker.interceptEachListItem(
          i, ListItemControllerStateWrapper(listItemControllerState), oldItemTypeList, newColumnChildListItemControllerState
        );
        j++;
      }
      newItemTypeList.add(
        CarouselListItemControllerState(
          padding: oldItemType.padding,
          betweenTitleDescriptionAndCarouselItemVerticalSpace: oldItemType.betweenTitleDescriptionAndCarouselItemVerticalSpace,
          itemListItemControllerState: newColumnChildListItemControllerState,
          title: oldItemType.title,
          titleInterceptor: oldItemType.titleInterceptor,
          description: oldItemType.description,
          descriptionInterceptor: oldItemType.descriptionInterceptor,
          carouselBackground: oldItemType.carouselBackground
        )
      );
      return true;
    }
    return false;
  }
}