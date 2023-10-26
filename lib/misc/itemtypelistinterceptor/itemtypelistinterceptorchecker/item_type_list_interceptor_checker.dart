import '../item_type_list_interceptor_parameter.dart';
import '../item_type_list_interceptor_result.dart';

abstract class ItemTypeListInterceptorChecker<ItemType> {
  ItemTypeListInterceptorResult<ItemType> intercept(List<ItemType> oldItemTypeList, ItemTypeListInterceptorParameter<ItemType> itemTypeListInterceptorParameter);
}