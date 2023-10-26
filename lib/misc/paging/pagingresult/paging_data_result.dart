import 'paging_result.dart';

class PagingDataResult<ItemType> extends PagingResult<ItemType> {
  final int page;
  int totalPage;
  int totalItem;
  List<ItemType> itemList;

  PagingDataResult({
    required this.page,
    required this.totalPage,
    required this.totalItem,
    required this.itemList
  });
}