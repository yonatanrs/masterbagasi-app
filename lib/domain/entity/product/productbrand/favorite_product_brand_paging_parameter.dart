class FavoriteProductBrandPagingParameter {
  int page;
  int itemEachPageCount;

  FavoriteProductBrandPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}