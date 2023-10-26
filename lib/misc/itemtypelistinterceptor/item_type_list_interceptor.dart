import 'item_type_list_interceptor_parameter.dart';
import 'item_type_list_interceptor_result.dart';
import 'itemtypelistinterceptorchecker/item_type_list_interceptor_checker.dart';

abstract class ItemTypeListInterceptor<ItemType> {
  ItemTypeListInterceptorResult<ItemType> intercept(List<ItemType> oldItemTypeList, ItemTypeListInterceptorParameter<ItemType> itemTypeListInterceptorParameter) {
    ItemTypeListInterceptorParameter<ItemType> tempItemTypeListInterceptorParameter = itemTypeListInterceptorParameter;
    List<ItemTypeListInterceptorChecker<ItemType>> cachedItemTypeListInterceptorCheckerList = itemTypeListInterceptorCheckerList;
    int i = 0;
    List<ItemType> interceptedItemTypeList = oldItemTypeList;
    List<ItemType> interceptedAdditionalItemTypeList = tempItemTypeListInterceptorParameter.additionalItemTypeList;
    ItemTypeListInterceptorResult<ItemType> itemTypeListInterceptorResult = ItemTypeListInterceptorResult<ItemType>(
      allInterceptedItemTypeList: interceptedItemTypeList + interceptedAdditionalItemTypeList,
      interceptedItemTypeList: interceptedItemTypeList,
      interceptedAdditionalItemTypeList: interceptedAdditionalItemTypeList
    );
    while (i < itemTypeListInterceptorCheckerList.length) {
      ItemTypeListInterceptorChecker<ItemType> itemTypeListInterceptorChecker = cachedItemTypeListInterceptorCheckerList[i];
      itemTypeListInterceptorResult = itemTypeListInterceptorChecker.intercept(itemTypeListInterceptorResult.interceptedItemTypeList, tempItemTypeListInterceptorParameter);
      tempItemTypeListInterceptorParameter = tempItemTypeListInterceptorParameter.copy(additionalItemTypeList: itemTypeListInterceptorResult.interceptedAdditionalItemTypeList);
      i++;
    }
    return itemTypeListInterceptorResult;
  }

  List<ItemTypeListInterceptorChecker<ItemType>> get itemTypeListInterceptorCheckerList;
}