import '../typedef.dart';
import 'item_type_list_interceptor.dart';
import 'itemtypelistinterceptorchecker/item_type_list_interceptor_checker.dart';
import 'itemtypelistinterceptorchecker/list_item_controller_state_item_type_list_interceptor_checker.dart';

class DefaultItemTypeListInterceptor<ItemType> extends ItemTypeListInterceptor<ItemType> {
  final DoubleReturned padding;
  final DoubleReturned itemSpacing;

  DefaultItemTypeListInterceptor({
    required this.padding,
    required this.itemSpacing
  }) : super();

  @override
  List<ItemTypeListInterceptorChecker<ItemType>> get itemTypeListInterceptorCheckerList => [
    ListItemControllerStateItemTypeInterceptorChecker(
      padding: padding,
      itemSpacing: itemSpacing
    ) as ItemTypeListInterceptorChecker<ItemType>
  ];
}