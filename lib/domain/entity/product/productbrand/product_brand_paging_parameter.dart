class ProductBrandPagingParameter {
  int page;
  int itemEachPageCount;

  ProductBrandPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}