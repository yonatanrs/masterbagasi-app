class ItemTypeListInterceptorResult<ItemType> {
  List<ItemType> allInterceptedItemTypeList;
  List<ItemType> interceptedItemTypeList;
  List<ItemType> interceptedAdditionalItemTypeList;

  ItemTypeListInterceptorResult({
    required this.allInterceptedItemTypeList,
    required this.interceptedItemTypeList,
    required this.interceptedAdditionalItemTypeList
  });
}