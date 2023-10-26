class ProductBundlePagingParameter {
  int page;
  int itemEachPageCount;

  ProductBundlePagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}