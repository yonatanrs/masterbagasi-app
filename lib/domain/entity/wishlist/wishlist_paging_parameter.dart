class WishlistPagingParameter {
  int page;
  int itemEachPageCount;

  WishlistPagingParameter({
    required this.page,
    this.itemEachPageCount = 15
  });
}