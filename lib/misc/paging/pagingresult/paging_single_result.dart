import 'paging_result.dart';

class PagingSingleResult<ItemType> extends PagingResult<ItemType> {
  ItemType item;

  PagingSingleResult({
    required this.item
  });
}