class ItemTypeListInterceptorParameter<ItemType> {
  List<ItemType> additionalItemTypeList;

  ItemTypeListInterceptorParameter({
    required this.additionalItemTypeList
  });

  ItemTypeListInterceptorParameter<ItemType> copy({
    bool? hasAdditionalLoadingIndicator,
    List<ItemType>? additionalItemTypeList
  }) {
    return ItemTypeListInterceptorParameter(
      additionalItemTypeList: additionalItemTypeList ?? this.additionalItemTypeList
    );
  }
}