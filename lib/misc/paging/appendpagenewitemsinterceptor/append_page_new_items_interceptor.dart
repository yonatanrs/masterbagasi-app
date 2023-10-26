abstract class AppendPageNewItemsInterceptor<PageKeyType, ItemType> {
  List<ItemType> intercept(List<ItemType> newItems, PageKeyType? nextPageKey);
}