class ModifiedPagingItemWrapper<PageKeyType, ItemType> {
  final PageKeyType? pageKey;
  final ItemType item;

  ModifiedPagingItemWrapper({
    this.pageKey,
    required this.item
  });
}