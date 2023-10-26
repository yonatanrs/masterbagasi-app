class ProductCategoryPagingParameter {
  int page;
  int itemEachPageCount;

  ProductCategoryPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}