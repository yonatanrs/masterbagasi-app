import 'paging_result.dart';

class PagingListResult<ItemType> extends PagingResult<ItemType> {
  List<ItemType> itemList;

  PagingListResult({
    required this.itemList
  });
}