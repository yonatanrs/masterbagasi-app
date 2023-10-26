import 'cart_paging_parameter.dart';

class SharedCartPagingParameter extends CartPagingParameter {
  String hostCartId;

  SharedCartPagingParameter({
    required super.page,
    required super.itemEachPageCount,
    required this.hostCartId
  });
}