import 'paging_result.dart';

class PagingResultWithParameter<ItemType> extends PagingResult<ItemType> {
  PagingResult<ItemType> pagingResult;
  PagingResultParameter<ItemType> pagingResultParameter;

  PagingResultWithParameter({
    required this.pagingResult,
    required this.pagingResultParameter
  });
}

class PagingResultParameter<ItemType> {
  List<ItemType>? additionalItemList;
  bool showOriginalLoaderIndicator;

  PagingResultParameter({
    this.additionalItemList,
    required this.showOriginalLoaderIndicator
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PagingResultParameter<ItemType>
      && other.additionalItemList == additionalItemList
      && other.showOriginalLoaderIndicator == showOriginalLoaderIndicator;
  }

  @override
  int get hashCode => additionalItemList.hashCode;
}