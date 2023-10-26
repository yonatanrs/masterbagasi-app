class ProductPagingParameter {
  int page;
  int itemEachPageCount;

  ProductPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}